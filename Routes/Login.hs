module Routes.Login where

import Data.Time.Clock
import Data.Maybe

import Import

data Login    = Login    Text Text
data Register = Register Text Text Text

loginForm :: Form Login
loginForm = renderBootstrap3 BootstrapBasicForm $ Login
  <$> areq textField     (withPlaceholder "Enter username" $ bfs ("Username" :: Text)) Nothing
  <*> areq passwordField (withPlaceholder "Enter password" $ bfs ("Password" :: Text)) Nothing

registerForm :: Form Register
registerForm = renderBootstrap3 BootstrapBasicForm $ Register
  <$> areq textField     (withPlaceholder "Enter username"   $ bfs ("Username"         :: Text)) Nothing
  <*> areq passwordField (withPlaceholder "Enter password"   $ bfs ("Password"         :: Text)) Nothing
  <*> areq passwordField (withPlaceholder "Confirm password" $ bfs ("Confirm Password" :: Text)) Nothing

getLoginR :: Handler Html
getLoginR = do
  (loginForm   , loginEnctype   ) <- generateFormPost loginForm
  (registerForm, registerEnctype) <- generateFormPost registerForm
  defaultLayout ($(widgetFile "login"))

getLogoutR :: Handler ()
getLogoutR = do
  deleteSession "loggedin"
  setMessage "Logged out!"
  redirect HomeR

postLoginR :: Handler ()
postLoginR = do
  ((result, _), _) <- runFormPost loginForm

  case result of
    FormFailure _ -> do
      setMessage "Could not validate the form."
      redirect LoginR
    FormSuccess (Login username password) -> do
      muser <- runSqlite dbLocation $ getBy $ UniqueCombo username $ hash password

      if isNothing muser
        then do
          setMessage "Invalid username / password."
          redirect LoginR
        else do
          setSession "loggedin" username
          setMessage "Logged in!"
          redirect HomeR

postRegisterR :: Handler ()
postRegisterR = do
  ((result, _), _) <- runFormPost registerForm

  case result of
    FormFailure _ -> do
      setMessage "Could not validate the form."
      redirect LoginR
    FormSuccess (Register username password cpassword) -> do
      if password /= cpassword
        then do
          setMessage "Passwords do not match"
          redirect LoginR
        else do
          muser <- runSqlite dbLocation $ getBy $ UniqueName username

          if isNothing muser
            then do
              runSqlite dbLocation $ do
                time <- liftIO getCurrentTime
                insert $ User username (hash password) Nothing Nothing Nothing Nothing time

              setMessage "Registered!"
              redirect LoginR
            else do
              setMessage "Username is taken!"
              redirect LoginR
