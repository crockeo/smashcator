module Routes.Tournaments where

import Data.Int

import Import

makeId :: Key Tournament -> Int
makeId key =
  case fromPersistValue $ unKey key :: Either Text Int64 of
    Left  _ -> 0
    Right v -> fromIntegral v

getTournamentsR :: Handler Html
getTournamentsR = do
  tournaments <- runSqlite dbLocation $ selectList [] []

  defaultLayout ($(widgetFile "tournaments"))
