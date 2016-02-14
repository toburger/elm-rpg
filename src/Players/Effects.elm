module Players.Effects (..) where

import Effects exposing (Effects)
import Http
import Json.Decode as Decode exposing ((:=))
import Task
import Players.Models exposing (PlayerId, Player)
import Players.Actions exposing (..)

fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/players"


memberDecoder : Decode.Decoder Player
memberDecoder =
  Decode.object3
    Player
    ("id" := Decode.int)
    ("name" := Decode.string)
    ("level" := Decode.int)


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
  Decode.list memberDecoder


fetchAll : Effects Action
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map FetchAllDone
    |> Effects.task
