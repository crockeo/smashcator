module Routes.User where

import qualified Data.Text as T

import Database.Persist.Sqlite
import Database.Persist

import Yesod

import Foundation
import WidgetFile
import SmashDB

getUserR :: T.Text -> Handler Html
getUserR username = do
  pusers <- runSqlite dbLocation $ selectList [UserUsername ==. username] []
  mloggedin <- lookupSession "loggedin"

  let muser = if null pusers
               then Nothing
               else Just $ head pusers in
    defaultLayout ($(widgetFile "user"))
