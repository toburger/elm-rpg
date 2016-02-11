module Models (..) where

import Players.Models exposing (Player)


type alias Model =
  { players : List Player
  }


initialModel : Model
initialModel =
  { players = [ Player 1 "Sam" 1 ]
  }
