{-# LANGUAGE OverloadedStrings #-}

module Neo.Slack (Status(..), updateStatus) where

import           Data.Aeson              (ToJSON (..), Value, decode, encode)
import qualified Data.ByteString.Lazy    as LB
import           Network.HTTP.Client
import qualified Network.HTTP.Client.TLS as TLS


data Status = Status
    { text       :: String
    , emoji      :: String
    , expiration :: Int
    }


instance ToJSON Status where
  toJSON = undefined


endpoint :: Status -> Request
endpoint status = "https://api.slack.com/api/users.profile.set"
  { method = "POST"
  , secure = True
  , requestBody = RequestBodyLBS $ encode status
  }


updateStatus :: Status -> IO (Response (Maybe Value))
updateStatus status = do
  man <- TLS.newTlsManager
  resp <- httpLbs (endpoint status) man
  return $ resp {
    responseBody = decode $ responseBody resp
  }
