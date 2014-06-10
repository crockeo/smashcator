module Routes.Contact where

import qualified Data.Text as T
import Control.Applicative ((<$>), (<*>))

import Yesod

import Foundation
import WidgetFile

data ContactPost = ContactPost T.Text T.Text

getContactR :: Handler Html
getContactR =
  defaultLayout ($(widgetFile "contact"))

postContactR :: Handler Html
postContactR = do
  (ContactPost subject message) <- runInputPost $ ContactPost
    <$> ireq textField "subject"
    <*> ireq textField "message"

  -- TODO: Programmatically send email

  redirect ContactR
