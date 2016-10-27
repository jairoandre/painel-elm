module Api exposing (..)

import Model exposing (PainelJson, painelJsonDecoder)
import CepamModel exposing (CepamJson, cepamJsonDecoder)
import Http
import Task


apiHost : String
apiHost =
    "http://localhost:8080/painel/"


getJsonPainel : String -> (Http.Error -> a) -> (PainelJson -> a) -> Cmd a
getJsonPainel asa error success =
    Task.perform error success (Http.get painelJsonDecoder ("rest/api/painel/" ++ asa))


getJsonCepam : (Http.Error -> a) -> (CepamJson -> a) -> Cmd a
getJsonCepam error success =
    Task.perform error success (Http.get cepamJsonDecoder "rest/api/cepam")
