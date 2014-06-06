module Routes.Login where

import Yesod

import Foundation
import WidgetFile

getLoginR :: Handler Html
getLoginR =
  defaultLayout ($(widgetFile "login"))

postLoginR :: Handler Html
postLoginR = undefined

postRegisterR :: Handler Html
postRegisterR = undefined
