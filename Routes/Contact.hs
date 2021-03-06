module Routes.Contact where

import qualified Data.Text.Lazy as LT
import qualified Data.Text as T

import Import

data ContactPost = ContactPost T.Text T.Text

-- The login file location
loginFile :: FilePath
loginFile = "login"

-- Loading the login information
loadLogin :: FilePath -> IO (LT.Text, LT.Text)
loadLogin fp = do
  content <- readFile fp

  case lines content of
    (username:password:[]) -> return (LT.pack username, LT.pack password)
    l                      -> return ("NULL", "NULL")

getContactR :: Handler Html
getContactR =
  defaultLayout ($(widgetFile "contact"))

postContactR :: Handler Html
postContactR = do
  (ContactPost subject message) <- runInputPost $ ContactPost
    <$> ireq textField "subject"
    <*> ireq textField "message"

  (username, password) <- liftIO $ loadLogin loginFile

  liftIO $ sendGmail
    username
    password
    (Address (Just "Crockeo") "crockeo@gmail.com")
    [Address (Just "Crockeo") "crockeo@gmail.com"]
    []
    []
    ("Smashcator Contact - " <> subject)
    (LT.pack $ T.unpack message)
    []

  redirect ContactR
