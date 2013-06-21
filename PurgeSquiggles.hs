
import Control.Monad (forM)
import System.Directory (doesDirectoryExist, getDirectoryContents,removeFile)
import System.FilePath ((</>))


main = do
	cake <- getRecursiveContents "/home/cory"
	let jake = filter endsWithSquiggle cake
	mapM_ removeFile jake

getRecursiveContents :: FilePath -> IO [FilePath]

getRecursiveContents topdir = do
  names <- getDirectoryContents topdir
  let properNames = filter (\x -> '.' /= head x) names
  paths <- forM properNames $ \name -> do
    let path = topdir </> name
    isDirectory <- doesDirectoryExist path
    if isDirectory
      then getRecursiveContents path
      else return [path]
  return (concat paths)

endsWithSquiggle :: String -> Bool
endsWithSquiggle xs =  ('~' == lastElem xs)

lastElem :: [a] -> a
lastElem [] = error "Empty List"
lastElem [a] = a
lastElem (_:xs) = lastElem xs 
