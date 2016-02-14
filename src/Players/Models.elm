module Players.Models (..) where


type alias PlayerId =
  Int


type alias Player =
  { id : PlayerId
  , name : String
  , level : Int
  }


new : Player
new =
  { id = 0
  , name = ""
  , level = 1
  }


type alias Model =
  { players : List Player
  , showErrorAddress : Signal.Address String
  }
