module Routes.Login where

import Control.Applicative ((<$>), (<*>))
import qualified Data.Text as T
import Data.Hashable

import Database.Persist.Sqlite
import Database.Persist

import Yesod

import Foundation
import WidgetFile
import SmashDB

data LoginPost    = LoginPost    T.Text T.Text
data RegisterPost = RegisterPost T.Text T.Text T.Text

getLoginR :: Handler Html
getLoginR =
  defaultLayout ($(widgetFile "login"))

postLoginR :: Handler ()
postLoginR = do
  (LoginPost username password) <- runInputPost $ LoginPost
    <$> ireq textField     "username"
    <*> ireq passwordField "password"

  users <- runSqlite dbLocation $ selectList [UserUsername ==. username, UserPassword ==. hash password] [LimitTo 1]

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

  redirect LoginR
