module Handler.Article where

import Import
import Handler.Forms
import Yesod.Auth

-- TODO: Need generic 'Content' model Type for handling everything.

-- | Show all Posts
getMediaR :: Handler RepHtml
getMediaR = do
	--muser <- maybeAuth
	-- Retrieve all posts inside the database, most recent first.
	articles <- runDB $ selectList [] [Desc ArticlePosted] 
	(articleWidget, enctype) <- generateFormPost entryForm
	defaultLayout $ do
	    $(widgetFile "articles")

-- | Handle creation of new Post
postMediaR :: Handler RepHtml
postMediaR = do
    ((res,articleWidget),enctype) <- runFormPost entryForm
    case res of
      FormSuccess article -> do
        articleId <- runDB $ insert article
        setMessage $ toHtml $ (articleTitle article)
        redirect $ ArticleR articleId
      _ -> defaultLayout $ do
        setTitle "Please correct your entry form"
        $(widgetFile "articleadderror")


-- | Retrieve a Specific Post
getArticleR :: ArticleId -> Handler RepHtml
getArticleR articleId = do
	(article, comments) <- runDB $ do
	    article <- get404 articleId
	    comments <- selectList [CommentArticle ==. articleId] [Asc CommentPosted] -- ^ Get the Comments in Ascending order.
	    return (article, comments)		-- map entityVal
	articles <- runDB $ selectList [] [Desc ArticleTitle]
	muser <- maybeAuth
	(commentWidget, enctype) <- generateFormPost (commentForm articleId)
	defaultLayout $ do
	    setTitle $ toHtml $ articleTitle article
	    $(widgetFile "article")

{-
getArticleR :: ArticleId -> Handler RepHtml
getArticleR articleId = do
    article <- runDB $ get404 articleId
    defaultLayout $ do
        setTitle $ toHtml $ articleTitle article
        $(widgetFile "article")
-}


-- | Create a Comment
postArticleR :: ArticleId -> Handler RepHtml
postArticleR articleId = do
	((res, commentWidget), enctype) <- runFormPost (commentForm articleId)
	case res of
	  FormSuccess comment -> do
	    _ <- runDB $ insert comment
	    setMessage "Comment added"
	    redirect $ ArticleR articleId
	  _ -> defaultLayout $ do
	    setTitle "Please Correct"
	    $(widgetFile "badComment")


