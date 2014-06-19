module Routes.Tournament where

import Import

data NewTournament = NewTournament Bool Text Text Text (Maybe Text) [Text] Textarea Textarea
  deriving (Show)

newTournamentForm :: Form NewTournament
newTournamentForm = renderBootstrap3 BootstrapBasicForm $ NewTournament
  <$> areq checkBoxField                   "Public"                                                                         Nothing
  <*> areq textField                       (withPlaceholder "Enter title"                $ bfs ("Title"           :: Text)) Nothing
  <*> areq textField                       (withPlaceholder "Enter location"             $ bfs ("Location"        :: Text)) Nothing
  <*> areq textField                       (withPlaceholder "Enter date"                 $ bfs ("Date"            :: Text)) Nothing
  <*> aopt textField                       (withPlaceholder "Enter background image url" $ bfs ("BackgroundImage" :: Text)) Nothing
  <*> areq (checkboxesFieldList gamesList) "Games:"                                                                         Nothing
  <*> areq textareaField                   (withPlaceholder "Enter description"          $ bfs ("Description"     :: Text)) Nothing
  <*> areq textareaField                   (withPlaceholder "Enter ruleset"              $ bfs ("Ruleset"         :: Text)) Nothing
  where gamesList :: [(Text, Text)]
        gamesList = [ ("Super Smash Bros. 64"   , "64"   )
                    , ("Super Smash Bros. Melee", "melee")
                    , ("Super Smash Bros. Brawl", "brawl")
                    , ("Project M"              , "pm"   )
                    ]

getTournamentR :: Int -> Handler Html
getTournamentR id = do
  mtournament <- runSqlite dbLocation $ get $ Key $ PersistInt64 $ fromIntegral id
  defaultLayout ($(widgetFile "tournament"))

getNewTournamentR :: Handler Html
getNewTournamentR = do
  (form, enctype) <- generateFormPost newTournamentForm
  defaultLayout ($(widgetFile "newtournament"))

postNewTournamentR :: Handler ()
postNewTournamentR = do
  ((nt, _), _) <- runFormPost newTournamentForm
  liftIO $ print nt
  redirect NewTournamentR
