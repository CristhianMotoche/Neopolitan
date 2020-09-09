{-# LANGUAGE OverloadedStrings #-}

module Neo.Slack (Status, updateStatus) where

import           Data.Aeson              (Value, decode)
import qualified Data.ByteString.Lazy    as LB
import           Network.HTTP.Client
import qualified Network.HTTP.Client.TLS as TLS


data Status = Status
    { text       :: String
    , emoji      :: String
    , expiration :: Int
    }


endpoint :: Request
endpoint = "https://api.slack.com/api/users.profile.set"
  { method = "POST"
  , secure = True
  }


updateStatus :: IO (Response (Maybe Value))
updateStatus = do
  man <- TLS.newTlsManager
  resp <- httpLbs endpoint man
  return $ resp {
    responseBody = decode $ responseBody resp
  }

