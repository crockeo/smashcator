module Utils
  ( makeUTCTime
  , canSee
  , canSee'
  , getTournamentHost
  , getTournamentModerators
  , getTournamentAttending
  , getTournamentInvited
  ) where

import Import

makeUTCTime :: Day -> UTCTime
makeUTCTime day = UTCTime day $ secondsToDiffTime 0

canSee :: Tournament -> Maybe UserId -> Bool
canSee tournament Nothing     = tournamentPublic tournament
canSee tournament (Just user) =
  (tournamentPublic tournament)               ||
  (tournamentHost tournament) == user         ||
  elem user (tournamentModerators tournament) ||
  elem user (tournamentAttending  tournament) ||
  elem user (tournamentInvited    tournament)

canSee' :: Maybe UserId -> Tournament -> Bool
canSee' user tournament = canSee tournament user

getTournamentHost :: Tournament -> IO (Maybe User)
getTournamentHost tournament = runSqlite dbLocation $ get $ tournamentHost tournament

applyGetTournament :: (Tournament -> [UserId]) -> Tournament -> IO [Maybe User]
applyGetTournament fn tournament =
  sequence $ map (runSqlite dbLocation . get) $ fn tournament

getTournamentModerators = applyGetTournament tournamentModerators
getTournamentAttending  = applyGetTournament tournamentAttending
getTournamentInvited    = applyGetTournament tournamentInvited
