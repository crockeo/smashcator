module Utils where

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
