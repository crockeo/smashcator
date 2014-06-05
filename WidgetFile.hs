module WidgetFile (widgetFile) where

--------------------
-- Global Imports --
import Yesod.Default.Util (widgetFileReload, widgetFileNoReload)
import Yesod

import Data.Default (def)

----------
-- Code --
widgetFile name = widgetFileReload def name