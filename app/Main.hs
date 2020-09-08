module Main where

import           System.Environment (getArgs)

import           Neo

main :: IO ()
main = do
  config <- Neo.readConfig
  args <- getArgs
  resp <- Neo.updateStatus
  print resp
  return ()
