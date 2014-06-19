module Import ( module Import
              , (<>)
              ) where

import Data.Hashable             as Import
import Data.Monoid               as Import (Monoid (mappend, mempty, mconcat))
import Data.Text                 as Import (Text)

import Network.Mail.Client.Gmail as Import
import Network.Mail.Mime         as Import

import Control.Applicative       as Import ((<$>), (<*>), pure)
import Control.Monad             as Import

import Database.Persist.Sqlite   as Import
import Database.Persist          as Import

import Yesod.Form.Bootstrap3     as Import
import Yesod.Static              as Import
import Yesod.Form                as Import
import Yesod                     as Import

import Foundation                as Import
import WidgetFile                as Import
import SmashDB                   as Import

infixr 5 <>
(<>) :: Monoid m => m -> m -> m
(<>) = mappend
