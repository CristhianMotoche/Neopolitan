module Main where

import           Lib


newtype Hook = Hook String


readHook :: FilePath -> IO Hook
readHook filename = Hook . filter (/= '\n') <$> readFile filename


main :: IO ()
main = do
  Hook hook <- readHook "hook"
  putStrLn hook
