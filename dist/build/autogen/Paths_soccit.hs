module Paths_soccit (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/dbader/.cabal/bin"
libdir     = "/home/dbader/.cabal/lib/x86_64-linux-ghc-7.10.3/soccit-0.1.0.0-6VGicYl60AH8gmPDfOdBCD"
datadir    = "/home/dbader/.cabal/share/x86_64-linux-ghc-7.10.3/soccit-0.1.0.0"
libexecdir = "/home/dbader/.cabal/libexec"
sysconfdir = "/home/dbader/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "soccit_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "soccit_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "soccit_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "soccit_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "soccit_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
