module Routes.EditUser where

import Import

data EditUser = EditUser (Maybe Text) (Maybe Text) (Maybe Text) (Maybe Text) (Maybe Text) (Maybe Textarea) Text

editUserForm :: Form EditUser
editUserForm = renderBootstrap3 BootstrapBasicForm $ EditUser
  <$> aopt passwordField (withPlaceholder "Enter new password"   $ bfs ("New Password"     :: Text)) Nothing
  <*> aopt passwordField (withPlaceholder "Confirm new password" $ bfs ("Confirm Password" :: Text)) Nothing
  <*> aopt urlField      (withPlaceholder "Enter icon url"       $ bfs ("Icon"             :: Text)) Nothing
  <*> aopt textField     (withPlaceholder "Enter short bio"      $ bfs ("Short Bio"        :: Text)) Nothing
  <*> aopt textField     (withPlaceholder "Enter location"       $ bfs ("Location"         :: Text)) Nothing
  <*> aopt textareaField (withPlaceholder "Enter long bio"       $ bfs ("Long Bio"         :: Text)) Nothing
  <*> areq passwordField (withPlaceholder "Enter password"       $ bfs ("Password"         :: Text)) Nothing

getEditUserR :: Text -> Handler Html
getEditUserR username = do
  (form, enctype) <- generateFormPost editUserForm
  muser           <- runSqlite dbLocation $ getBy $ UniqueName username
  mloggedin       <- lookupSession "loggedin"

  defaultLayout ($(widgetFile "edituser"))

postEditUserR :: Text -> Handler ()
postEditUserR username = do
  ((result, _), _) <- runFormPost editUserForm

  case result of
    FormFailure _ -> do
      setMessage "Could not validate form."
      redirect $ EditUserR username
    FormSuccess (EditUser mnewpassword mcnewpassword micon mshortbio mlocation mlongbio password) -> do
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
                when (newpassword == cnewpassword) $
                  update userId [UserPassword =. hash newpassword]

            update userId [UserIcon     =. micon    ]
            update userId [UserShortbio =. mshortbio]
            update userId [UserLocation =. mlocation]
            update userId [UserLongbio  =. fmap unTextarea mlongbio]

          redirect $ UserR username
