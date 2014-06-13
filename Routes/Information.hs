module Routes.Information where

import Import

getInformationR :: Handler Html
getInformationR =
  defaultLayout ($(widgetFile "information"))
  where email  = "crockeo@gmail.com" :: Text
        github = "http://github.com/Crockeo/smashcator" :: Text
