module Routes.User where

import Import

getUserR :: Text -> Handler Html
getUserR username = do
  pusers <- runSqlite dbLocation $ selectList [UserUsername ==. username] []
  mloggedin <- lookupSession "loggedin"

  let muser = if null pusers
               then Nothing
               else Just $ head pusers in
    defaultLayout ($(widgetFile "user"))
