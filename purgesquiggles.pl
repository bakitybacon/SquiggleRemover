sub killsquiggles($);
killsquiggles("/home/cory");

sub killsquiggles($)
{
	opendir(DIR,"$_[0]");
        my @files = grep { !/^\.{1,2}$/ } readdir (DIR);
        closedir (DIR);

	for(@files)
	{
                $this = $_;
		#convert to absolute path
		$_ = "$_[0]/$_";
		unlink if (/~$/ and -f);	
		killsquiggles("$_") if (-d $_ and (not $this =~ /^\./));
	}
}
