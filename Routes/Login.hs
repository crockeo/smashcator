module Routes.Login where

import Control.Applicative ((<$>), (<*>))
import qualified Data.Text as T

import Yesod

import Foundation
import WidgetFile

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

  redirect LoginR

postRegisterR :: Handler ()
postRegisterR = do
  (RegisterPost username password cpassword) <- runInputPost $ RegisterPost
    <$> ireq textField     "username"
    <*> ireq passwordField "password"
    <*> ireq passwordField "cpassword"

  redirect LoginR
