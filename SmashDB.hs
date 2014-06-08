module SmashDB where

import Database.Persistent.Sqilte
import Database.Persistent.TH
import Database.Persistent

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
User
  username String
  password Int
|]

