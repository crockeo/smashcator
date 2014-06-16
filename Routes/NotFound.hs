module Routes.NotFound where

import Import

getNotFoundR :: Handler Html
getNotFoundR =
  defaultLayout ($(widgetFile "notfound"))