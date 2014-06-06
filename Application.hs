module Application where

----- --------------
-- Global Imports --
import Yesod

-------------------
-- Local Imports --
import Foundation

import Routes.Home
import Routes.Information
import Routes.Contact
import Routes.Tournaments
import Routes.Login
import Routes.Tournament
import Routes.NewTournament
import Routes.User
import Routes.NewUser

----------
-- Code --
mkYesodDispatch "App" resourcesApp
