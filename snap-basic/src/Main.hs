{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Applicative
import           Snap.Core
import           Snap.Util.FileServe
import           Snap.Http.Server

main :: IO ()
main = quickHttpServe site

site :: Snap ()
site =
    ifTop (writeBS "hello world") <|>
    route [ ("foo", writeBS "bar")
          , ("media/:mediaTitle", mediaR)
          ] <|>
    dir "static" (serveDirectory ".")

mediaR :: Snap ()
mediaR = do
    param <- getParam "mediaTitle"
    maybe (writeBS "All Media")
        writeBS param
