module Handler.Authentication where

import Import
import Yesod.Auth

isAuthorized MediaR True = do
    mauth <- maybeAuth
    case mauth of
      Nothing -> return AuthenticationRequired
      Just (Entity _ user)
        | isAdmin user -> return Authorized
        | otherwise -> return AuthenticationRequired
isAuthorized _ True = Authorized


-- Add your username here to be admin.
isAdmin user =
  case userIdent user of
    "danh" 	-> True
    _ 		-> False
    -- Insert name above "_ -> False" line.
