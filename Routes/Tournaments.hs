module Routes.Tournaments where

import Import

getTournamentsR :: Handler Html
getTournamentsR = do
  tournaments <- runSqlite dbLocation $ selectList [] []

  defaultLayout ($(widgetFile "tournaments"))
