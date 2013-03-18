module Model where

import Prelude
import Yesod
import Data.Text (Text)
import Database.Persist.Quasi

import Data.Time
{-
newtype Hour a = Int a
newtype Minute = Int
--data HourMinute = Hour Minute deriving (read)

instance Show Hour where
    show a = if a < 10 then show ("0" ++ a) else show a 

instance Show Minute where
    show a = if a < 10 then show ("0" ++ a) else show a 
-}

-- You can define all of your database entities in the entities file.
-- You can find more information on persistent and how to declare entities
-- at:
-- http://www.yesodweb.com/book/persistent/
share [mkPersist sqlOnlySettings, mkMigrate "migrateAll"]
    $(persistFileWith lowerCaseSettings "config/models")
