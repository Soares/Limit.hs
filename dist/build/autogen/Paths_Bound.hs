module Paths_Bound (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,0], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/nate/bin"
libdir     = "/home/nate/lib/Bound-0.0/ghc-7.0.3"
datadir    = "/home/nate/share/Bound-0.0"
libexecdir = "/home/nate/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "Bound_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "Bound_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "Bound_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "Bound_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
