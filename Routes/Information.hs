module Routes.Information where

import qualified Data.Text as T

import Yesod

import Foundation
import WidgetFile

getInformationR :: Handler Html
getInformationR =
  defaultLayout ($(widgetFile "information"))
  where email  = "crockeo@gmail.com" :: T.Text
        github = "http://github.com/Crockeo/smashcator" :: T.Text
