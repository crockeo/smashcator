module Routes.Tournament where

import Database.Persist.Sqlite
import Database.Persist

import Yesod

import Foundation
import WidgetFile
import SmashDB

getTournamentR :: Int -> Handler Html
getTournamentR id = do
  mtournament <- runSqlite dbLocation $ get $ Key $ PersistInt64 $ fromIntegral id
  defaultLayout ($(widgetFile "tournament"))

postNewTournamentR :: Handler Html
postNewTournamentR = undefined
