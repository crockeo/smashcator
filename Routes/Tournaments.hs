module Routes.Tournaments where

import qualified Data.Text as T

import Import
import Utils

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
