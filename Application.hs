module Application where

----- --------------
-- Global Imports --
import Yesod

-------------------
-- Local Imports --
import Foundation

import Routes.Home

----------
-- Code --
mkYesodDispatch "App" resourcesApp
