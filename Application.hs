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
import Routes.User
import Routes.EditUser
import Routes.NotFound

----------
-- Code --
mkYesodDispatch "App" resourcesApp
