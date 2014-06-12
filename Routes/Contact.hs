module Routes.Contact where

import qualified Data.Text.Lazy as LT
import qualified Data.Text as T
import Control.Applicative ((<$>), (<*>))
import Network.Mail.Mime

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

  liftIO $ (simpleMail
    (Address (Just "Crockeo"   ) "crockeo@gmail.com")      -- Maintainer email
    (Address (Just "Smashcator") "contact@smashcator.com") -- Website email
    subject
    (LT.pack $ T.unpack message)
    ""
    []) >>= renderSendMail

  redirect ContactR
