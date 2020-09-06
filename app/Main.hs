module Main where

import           Neo

main :: IO ()
main = do
  config <- Neo.readConfig
  putStrLn "..."
