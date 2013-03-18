{-# LANGUAGE TypeFamilies, QuasiQuotes, MultiParamTypeClasses,
             TemplateHaskell, OverloadedStrings #-}
import Yesod
import Yesod.Form.Class
import Yesod.Form.Input

data Faith = Faith

instance Yesod Faith
instance RenderMessage Faith FormMessage where
    renderMessage _ _ = defaultFormMessage

mkYesod "Faith" [parseRoutes|
  / HomeR GET
  /testform TestR GET
|]

getHomeR = defaultLayout $ do
 setTitle "Faith Community Church - Rockford IL"; [whamlet|
    <form action=@{TestR} method=get >
     <input type=text name="content" >
     <input type=submit >
|]

type Form x = Html -> MForm Faith Faith (FormResult x, Widget)

getTestR :: Handler RepHtml
getTestR = do
    query <- runInputGet $ ireq textField "content"
    defaultLayout $ do [whamlet| <h1>#{query} |]


main = print "Starting..." >> warpEnv Faith

