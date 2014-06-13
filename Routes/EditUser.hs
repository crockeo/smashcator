module Routes.EditUser where

import Import

getEditUserR :: Text -> Handler Html
getEditUserR t = undefined

postEditUserR :: Text -> Handler ()
postEditUserR t = redirect $ EditUserR t