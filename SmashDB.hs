module SmashDB where

import Database.Persist.Sqlite
import Database.Persist.TH
import Database.Persist

import Data.Time.Clock

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
  public          Bool
  description     String  Maybe
  location        String  Maybe
  date            UTCTime Maybe
  ruleset         String  Maybe
  backgroundImage String  Maybe

ModeratorLink
  user       UserId
  tournament TournamentId

AttendingLink
  user       UserId
  tournament TournamentId

InvitedLink
  user       UserId
  tournament TournamentId
|]
