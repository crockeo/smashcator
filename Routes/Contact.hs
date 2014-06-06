module Routes.Contact where

import Yesod

import Foundation
import WidgetFile

getContactR :: Handler Html
getContactR =
  defaultLayout ($(widgetFile "contact"))
