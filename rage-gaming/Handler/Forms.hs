module Handler.Forms where

import Import
import Yesod.Form.Nic (nicHtmlField)
import Data.Time

--instance YesodNic App where
  --  urlNicEdit _ = Right "http://js.nicedit.com/nicEdit-latest.js"

-- FIXME: All forms cause "closure error"
entryForm :: Form Article
entryForm = renderDivs $ Article
	<$> areq textField "Title" Nothing
	<*> aformM (liftIO getCurrentTime)
	<*> areq nicHtmlField "Content" Nothing

commentForm :: ArticleId -> Form Comment
commentForm articleId= renderDivs $ Comment
	<$> pure articleId
	<*> aformM (liftIO getCurrentTime)
	<*> areq textField "Name" Nothing
	<*> areq textareaField "Comment" Nothing
	
sampleForm :: Form (FileInfo, Text)
sampleForm = renderDivs $ (,)
    <$> fileAFormReq "Choose a file"
    <*> areq textField "What's on the file?" Nothing
