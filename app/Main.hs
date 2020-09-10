module Main where

import           System.Environment (getArgs)

import           Neo                (Status (..), readConfig, updateStatus)


lunch :: Status
lunch = Status {
    text = "Lunch"
  , emoji = ":can:"
  , expiration = 12341234
  }

main :: IO ()
main = do
  config <- readConfig
  args <- getArgs
  resp <- updateStatus lunch
  print resp
  return ()
