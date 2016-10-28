module PainelNavigation exposing (..)

import UrlParser exposing (Parser, (</>), format, int, oneOf, s, string)
import Navigation
import String


toHash : Page -> String
toHash page =
    case page of
        Home ->
            "#home"

        Asa asa ->
            "#asa/" ++ asa

        Cpam ->
            "#cpam"

        Farmacia ->
            "#farmacia"


hasParser : Navigation.Location -> Result String Page
hasParser location =
    UrlParser.parse identity pageParser (String.dropLeft 1 location.hash)


pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ format Home (s "")
        , format Home (s "home")
        , format Asa (s "asa" </> string)
        , format Cpam (s "cpam")
        , format Farmacia (s "farmacia")
        ]


type Page
    = Home
    | Asa String
    | Cpam
    | Farmacia


type alias Parse =
    { url : String
    , asa : String
    }
