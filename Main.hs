module Main where

import Application
import Import

main :: IO ()
main = do
  runSqlite dbLocation $ runMigration migrateAll
  warp 80 App
