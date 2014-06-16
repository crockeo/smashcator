module Routes.User where

import Import

getUserR :: Text -> Handler Html
getUserR username = do
  muser <- runSqlite dbLocation $ getBy $ UniqueName username
  mloggedin <- lookupSession "loggedin"

  hosted <-
    case muser of
      Nothing             -> return []
      Just (Entity key _) -> runSqlite dbLocation $ selectList [TournamentHost ==. key] []

  moderated <-
    case muser of
      Nothing             -> return []
      Just (Entity key _) -> return [] -- TODO: Complete

  attended <-
    case muser of
      Nothing             -> return []
      Just (Entity key _) -> return [] -- TODO: Complete

  defaultLayout ($(widgetFile "user"))
