module SmashDB where

import Database.Persist.Sqlite
import Database.Persist.TH
import Database.Persist

import Data.Time.Clock
import Data.Text (Text)

-- Initializing the data schema
share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
User
  username Text
  password Int
  shortbio Text    Maybe
  longbio  Text    Maybe
  location Text    Maybe
  icon     Text    Maybe
  signedup UTCTime       default=CURRENT_TIME
  UniqueUser username

Tournament
  title           Text
  host            UserId
  moderators      [UserId]       default=[]
  attending       [UserId]       default=[]
  invited         [UserId]       default=[]
  public          Bool           default=False
  description     Text     Maybe
  location        Text     Maybe
  date            UTCTime  Maybe
  ruleset         Text     Maybe
  backgroundImage Text     Maybe
|]

-- Storing the database location
dbLocation :: Text
dbLocation = "smashcator.db"
