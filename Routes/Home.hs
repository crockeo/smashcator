module Routes.Home where

import Import

getHomeR :: Handler Html
getHomeR =
  defaultLayout ($(widgetFile "home"))
