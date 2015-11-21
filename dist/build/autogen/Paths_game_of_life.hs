module Paths_game_of_life (
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

bindir     = "/root/.cabal/bin"
libdir     = "/root/.cabal/lib/x86_64-linux-ghc-7.10.2/game-of-life-0.1.0.0-C36ukP6rX5rFGxnaGilrb1"
datadir    = "/root/.cabal/share/x86_64-linux-ghc-7.10.2/game-of-life-0.1.0.0"
libexecdir = "/root/.cabal/libexec"
sysconfdir = "/root/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "game_of_life_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "game_of_life_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "game_of_life_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "game_of_life_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "game_of_life_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
