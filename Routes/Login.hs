module Routes.Login where

import Data.Time.Clock
import Data.Hashable

import Import

data LoginPost    = LoginPost    Text Text
data RegisterPost = RegisterPost Text Text Text

getLoginR :: Handler Html
getLoginR =
  defaultLayout ($(widgetFile "login"))

getLogoutR :: Handler ()
getLogoutR = do
  deleteSession "loggedin"
  setMessage "Logged out!"
  redirect HomeR

postLoginR :: Handler ()
postLoginR = do
  (LoginPost username password) <- runInputPost $ LoginPost
    <$> ireq textField     "username"
    <*> ireq passwordField "password"

  users <- runSqlite dbLocation $ selectList [UserUsername ==. username, UserPassword ==. hash password] []

  if null users
    then do
      setMessage "Invalid username / password."
      redirect LoginR
    else do
      setSession "loggedin" username
      setMessage "Logged in!"
      redirect HomeR

postRegisterR :: Handler ()
postRegisterR = do
  (RegisterPost username password cpassword) <- runInputPost $ RegisterPost
    <$> ireq textField     "username"
    <*> ireq passwordField "password"
    <*> ireq passwordField "cpassword"

  if password /= cpassword
    then do
      setMessage "Passwords do not match"
      redirect LoginR
    else do
      users <- runSqlite dbLocation $ selectList [UserUsername ==. username] []

      if null users
        then do
          runSqlite dbLocation $ do
            time <- liftIO getCurrentTime
            insert $ User username (hash password) Nothing Nothing Nothing Nothing time

          setMessage "Registered!"
          redirect LoginR
        else do
          setMessage "Username is taken!"
          redirect LoginR
