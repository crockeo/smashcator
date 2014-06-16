module Foundation where

--------------------
-- Global Imports --
import qualified Data.Text as T

import Text.Hamlet (hamletFile)

import Yesod.Static
import Yesod

-------------------
-- Local Imports --
import WidgetFile

----------
-- Code --
data App = App
  { getStatic :: Static }

staticFiles "static"
mkYesodData "App" ($(parseRoutesFile "Routes/routes"))

instance Yesod App where
  defaultLayout widget = do
    app       <- getYesod
    mmsg      <- getMessage
    mloggedin <- lookupSession "loggedin"

    pc <- widgetToPageContent $ do
      setTitle "Smashcator"

      addStylesheetRemote "http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"
      addStylesheetRemote "http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css"

      addScriptRemote "http://code.jquery.com/jquery-2.1.1.min.js"
      addScriptRemote "http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"
      addScriptRemote "http://parsleyjs.org/dist/parsley.min.js"

      $(widgetFile "default-layout")

    giveUrlRenderer $(hamletFile "templates/default-layout-wrapper.hamlet")

  errorHandler NotFound = redirect NotFoundR
  errorHandler other    = defaultErrorHandler other

instance RenderMessage App FormMessage where
  renderMessage _ _ = defaultFormMessage
