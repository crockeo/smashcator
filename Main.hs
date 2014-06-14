module Main where

import Application
import Import

main :: IO ()
main = do
  runSqlite dbLocation $ runMigration migrateAll
  s <- static "static"
  warp 80 $ App s
