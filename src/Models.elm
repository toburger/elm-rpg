module Models (..) where

import Players.Models exposing (Player)
import Routing


type alias Model =
  { players : List Player
  , routing : Routing.Model
  }


initialModel : Model
initialModel =
  { players = [ Player 1 "Sam" 1 ]
  , routing = Routing.initialModel
  }
