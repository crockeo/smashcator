module Routes.Tournaments where

import Data.Int

import Import
import Utils

makeId :: Key Tournament -> Int
makeId key =
  case fromPersistValue $ unKey key :: Either Text Int64 of
    Left  _ -> 0
    Right v -> fromIntegral v

getTournamentsR :: Handler Html
getTournamentsR = do
  (UTCTime nday _) <- liftIO $ getCurrentTime
  rtournaments       <- runSqlite dbLocation $ selectList [] []
  mloggedin          <- lookupSession "loggedin"
  muser              <-
    case mloggedin of
      Nothing       -> return Nothing
      Just loggedin -> runSqlite dbLocation $ getBy $ UniqueName loggedin

  let tournaments = filter (canSee' (fmap entityKey muser) . entityVal) rtournaments in
   defaultLayout ($(widgetFile "tournaments"))
