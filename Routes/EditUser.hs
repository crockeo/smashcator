module Routes.EditUser where

import Import

import Data.String

data EditUserPost = EditUserPost (Maybe Text) (Maybe Text) (Maybe Text) (Maybe Text) (Maybe Text) (Maybe Text) Text

getEditUserR :: Text -> Handler Html
getEditUserR username = do
  muser <- runSqlite dbLocation $ getBy $ UniqueName username
  mloggedin <- lookupSession "loggedin"

  defaultLayout ($(widgetFile "edituser"))

postEditUserR :: Text -> Handler ()
postEditUserR username = do
  (EditUserPost mnewpassword mcnewpassword micon mshortbio mlocation mlongbio password) <- runInputPost $ EditUserPost
    <$> iopt passwordField "newpassword"
    <*> iopt passwordField "cnewpassword"
    <*> iopt textField     "icon"
    <*> iopt textField     "shortbio"
    <*> iopt textField     "location"
    <*> iopt textField     "longbio"
    <*> ireq passwordField "password"

  muser <- runSqlite dbLocation $ getBy $ UniqueCombo username $ hash password

  case muser of
    Nothing                   -> do
      setMessage "Invalid password."
      redirect $ EditUserR username
    Just (Entity userId user) -> do
      runSqlite dbLocation $ do
        case (mnewpassword, mcnewpassword) of
          (Nothing, _) -> return ()
          (_, Nothing) -> return ()
          (Just newpassword, Just cnewpassword) ->
            if newpassword == cnewpassword
              then update userId [UserPassword =. hash newpassword]
              else return ()

        update userId [UserIcon     =. micon    ]
        update userId [UserShortbio =. mshortbio]
        update userId [UserLocation =. mlocation]
        update userId [UserLongbio  =. mlongbio ]
      redirect $ UserR username
