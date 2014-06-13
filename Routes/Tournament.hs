module Routes.Tournament where

import Import

getTournamentR :: Int -> Handler Html
getTournamentR id = do
  mtournament <- runSqlite dbLocation $ get $ Key $ PersistInt64 $ fromIntegral id
  defaultLayout ($(widgetFile "tournament"))

postNewTournamentR :: Handler Html
postNewTournamentR = undefined
