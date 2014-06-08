module Main where

import Yesod

import Application
import Foundation
import SmashDB

main :: IO ()
main = do
  runSqlite "smashcator.db" $ runMigration migrateAll
  warp 80 App

