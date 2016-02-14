module Models (..) where

import Players.Models exposing (Player)
import Routing


type alias Model =
  { players : List Player
  , routing : Routing.Model
  , errorMessage : String
  }


initialModel : Model
initialModel =
  { players = []
  , routing = Routing.initialModel
  , errorMessage = ""
  }
