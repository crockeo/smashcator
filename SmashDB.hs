module SmashDB where

import qualified Data.Text as T

import Database.Persist.Sqlite
import Database.Persist.TH
import Database.Persist

import Data.Time.Clock

-- Initializing the data schema
share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
User
  username String
  password Int
  shortbio String  Maybe
  longbio  String  Maybe
  location String  Maybe
  icon     String  Maybe
  signedup UTCTime default=CURRENT_TIME

Tournament
  title           String
  host            UserId
  moderators      [UserId]
  attending       [UserId]
  invited         [UserId]
  public          Bool
  description     String  Maybe
  location        String  Maybe
  date            UTCTime Maybe
  ruleset         String  Maybe
  backgroundImage String  Maybe
|]

-- Storing the database location
dbLocation :: T.Text
dbLocation = "smashcator.db"
