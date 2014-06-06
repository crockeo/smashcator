module Routes.Home where

import Yesod.Form
import Yesod

import Foundation
import WidgetFile

getHomeR :: Handler Html
getHomeR =
  defaultLayout ($(widgetFile "home"))
