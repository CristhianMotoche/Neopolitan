{-# LANGUAGE OverloadedStrings #-}

import           Test.Tasty
import           Test.Tasty.HUnit

import           Data.Aeson       (encode)

import           Neo.Slack        (Status (..))


main :: IO ()
main = defaultMain tests


tests :: TestTree
tests = testGroup "Status"
  [ testCase "encode" $
    encode (Status "Foo" ":Bar:" 1234) @?= ""
  ]
