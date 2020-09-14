{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Neo.Slack (Status(..), updateStatus) where

import qualified Data.Aeson              as A
import qualified Data.ByteString.Lazy    as LB
import           Network.HTTP.Client
import qualified Network.HTTP.Client.TLS as TLS


data Status = Status
    { text       :: String
    , emoji      :: String
    , expiration :: Int
    }


instance A.ToJSON Status where
  toJSON (Status {..}) = A.object [
      "status_text" A..= text
    , "status_emoji" A..= emoji
    , "status_expiration" A..= expiration
    ]


endpoint :: Status -> Request
endpoint status = "https://api.slack.com/api/users.profile.set"
  { method = "POST"
  , secure = True
  , requestBody = RequestBodyLBS $ A.encode status
  , requestHeaders = [("Content-type", "application/json; charset=utf-8")]
  }


updateStatus :: Status -> IO (Response (Maybe A.Value))
updateStatus status = do
  man <- TLS.newTlsManager
  resp <- httpLbs (endpoint status) man
  return $ resp {
    responseBody = A.decode $ responseBody resp
  }
