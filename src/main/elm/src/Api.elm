module Api exposing (..)

import Model exposing (PainelJson, painelJsonDecoder)
import CpamModel exposing (CpamJson, cpamJsonDecoder)
import Http
import Task


apiHost : String
apiHost =
    --"http://10.1.0.105:8080/painel/"
    ""


getJsonPainel : String -> (Http.Error -> a) -> (PainelJson -> a) -> Cmd a
getJsonPainel asa error success =
    Task.perform error success (Http.get painelJsonDecoder (apiHost ++ "rest/api/painel/" ++ asa))


getJsonCpam : (Http.Error -> a) -> (CpamJson -> a) -> Cmd a
getJsonCpam error success =
    Task.perform error success (Http.get cpamJsonDecoder (apiHost ++ "rest/api/cpam"))
