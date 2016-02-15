module Models (..) where

import Players.Models exposing (Player)
import Perks.Models exposing (Perk)
import PerksPlayers.Models exposing (PerkPlayer)
import Routing


type alias Model =
  { players : List Player
  , perks : List Perk
  , perksPlayers : List PerkPlayer
  , routing : Routing.Model
  , errorMessage : String
  }


initialModel : Model
initialModel =
  { players = []
  , perks = []
  , perksPlayers = []
  , routing = Routing.initialModel
  , errorMessage = ""
  }
