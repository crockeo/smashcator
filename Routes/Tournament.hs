module Routes.Tournament where

import qualified Data.Text as T hiding (Text)

import Import

data NewTournament = NewTournament Bool Text (Maybe Text) (Maybe Text) (Maybe Text) [Text] Textarea Textarea
  deriving (Show)

newTournamentForm :: Form NewTournament
newTournamentForm = renderBootstrap3 BootstrapBasicForm $ NewTournament
  <$> areq checkBoxField                   "Public"                                                                         Nothing
  <*> areq textField                       (withPlaceholder "Enter title"                $ bfs ("Title"           :: Text)) Nothing
  <*> aopt textField                       (withPlaceholder "Enter location"             $ bfs ("Location"        :: Text)) Nothing
  <*> aopt textField                       (withPlaceholder "Enter date"                 $ bfs ("Date"            :: Text)) Nothing
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
  loggedin        <- lookupSession "loggedin"
  defaultLayout ($(widgetFile "newtournament"))

postNewTournamentR :: Handler ()
postNewTournamentR = do
  ((result, _), _) <- runFormPost newTournamentForm
  mloggedin        <- lookupSession "loggedin"
  muser            <-
    case mloggedin of
      Nothing       -> return Nothing
      Just loggedin -> runSqlite dbLocation $ getBy $ UniqueName loggedin

  case muser of
    Nothing -> setMessage "You are not logged in as a valid user." >> redirect NewTournamentR
    Just (Entity userId user) ->
      case result of
        FormFailure _ -> setMessage "Could not validate form." >> redirect NewTournamentR
        FormSuccess (NewTournament public title location date backgroundImage games description ruleset) -> do
          runSqlite dbLocation $
            insert $ Tournament { tournamentTitle           = title
                                , tournamentLocation        = location
                                , tournamentDate            = fmap (fst . head . reads . T.unpack) date
                                , tournamentBackgroundImage = backgroundImage
                                , tournamentGames           = games
                                , tournamentDescription     = unTextarea description
                                , tournamentRuleset         = unTextarea ruleset
                                , tournamentHost            = userId
                                , tournamentModerators      = []
                                , tournamentAttending       = []
                                , tournamentInvited         = []
                                , tournamentPublic          = public
                                }
          redirect TournamentsR
