module Main where

import           System.Environment (getArgs)

import           Neo                (Status (..), readConfig, updateStatus)


lunch :: Status
lunch = Status {
    text = "Lunch"
  , emoji = ":canned_food:"
  , expiration = 3600
  }

main :: IO ()
main = do
  config <- readConfig
  args <- getArgs
  resp <- updateStatus config lunch
  print resp
  return ()
