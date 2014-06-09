module SmashDB where

import qualified Data.Text as T

import Database.Persist.Sqlite
import Database.Persist.TH
import Database.Persist

import Data.Time.Clock

-- Initializing the data schema
share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
User
  username T.Text
  password Int
  shortbio T.Text  Maybe
  longbio  T.Text  Maybe
  location T.Text  Maybe
  icon     T.Text  Maybe
  signedup UTCTime default=CURRENT_TIME

Tournament
  title           T.Text
  host            UserId
  moderators      [UserId]
  attending       [UserId]
  invited         [UserId]
  public          Bool
  description     T.Text  Maybe
  location        T.Text  Maybe
  date            UTCTime Maybe
  ruleset         T.Text  Maybe
  backgroundImage T.Text  Maybe
|]

-- Storing the database location
dbLocation :: T.Text
dbLocation = "smashcator.db"
