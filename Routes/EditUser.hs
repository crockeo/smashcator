module Routes.EditUser where

import Import

getEditUserR :: Text -> Handler Html
getEditUserR username = do
  pusers <- runSqlite dbLocation $ selectList [UserUsername ==. username] []
  mloggedin <- lookupSession "loggedin"

  let muser = if null pusers
                then Nothing
                else Just $ head pusers in
    defaultLayout ($(widgetFile "edituser"))

postEditUserR :: Text -> Handler ()
postEditUserR t = redirect $ EditUserR t
