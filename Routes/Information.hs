module Routes.Information where

import Yesod

import Foundation
import WidgetFile

getInformationR :: Handler Html
getInformationR =
  defaultLayout ($(widgetFile "information"))
