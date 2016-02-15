module Perks.Effects (..) where

import Effects exposing (Effects)
import Http
import Json.Decode as Decode exposing ((:=))
import Task
import Perks.Models exposing (Perk)
import Perks.Actions as Actions


fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/perks"


perkDecoder : Decode.Decoder Perk
perkDecoder =
  Decode.object4
    Perk
    ("id" := Decode.int)
    ("name" := Decode.string)
    ("bonus" := Decode.int)
    ("description" := Decode.string)


collectionDecoder : Decode.Decoder (List Perk)
collectionDecoder =
  Decode.list perkDecoder


fetchAll : Effects Actions.Action
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map Actions.FetchAllDone
    |> Effects.task
