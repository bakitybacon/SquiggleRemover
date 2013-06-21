import java.io.File;
import java.io.IOException;
import java.io.FileFilter;
import java.util.Arrays;

public class PurgeSquiggles
{
	public static void main(String[]rgs) throws IOException
	{
		listFiles("/home/cory");
	}
	public static void listFiles(String dir) throws IOException
	{
		if(dir.startsWith("."))
			return;
		File f = new File(dir);
		if(f.isFile())
		{
			if(dir.matches(".+~$"))
				f.delete();
		}
		else if (f.isDirectory())
		{
			for(File bacon : f.listFiles(new PlainFileFilter()))
			{			
				if(bacon.getCanonicalPath().matches(".+~$"))
					bacon.delete();
			}
			for(File bacon : f.listFiles(new DirectoryFilter()))
			{
				listFiles(bacon.getAbsolutePath());
			}
		}
	}

}
class DirectoryFilter implements FileFilter
{

	@Override
	public boolean accept(File path)
	{
		if(path.getName().startsWith("."))
			return false;

		return path.isDirectory();
	}
}
class PlainFileFilter implements FileFilter
{

	
	@Override
	public boolean accept(File path)
	{
		if(path.getName().startsWith("."))
			return false;
		return path.isFile();
	}
}
