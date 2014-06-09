module Main where

import Database.Persist.Sqlite
import Database.Persist

import Yesod

import Application
import Foundation
import SmashDB

main :: IO ()
main = do
  runSqlite dbLocation $ runMigration migrateAll
  warp 80 App

