-- Model


module Main exposing (..)

import Dict exposing (Dict)
import Html exposing (Html, main_, header, h1, text, div, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


type alias Model =
    { counters : Dict String Int
    }


init : Model
init =
    { counters =
        Dict.fromList
            [ ( "Knapper", 0 )
            , ( "Glansbilder", 0 )
            , ( "Kroner", 0 )
            ]
    }



-- Update


type Msg
    = Increment String
    | Decrement String
    | IncrementAll
    | DecrementAll


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment thing ->
            { model | counters = Dict.update thing (Maybe.map (\c -> c + 1)) model.counters }

        Decrement thing ->
            { model | counters = Dict.update thing (Maybe.map (\c -> c - 1)) model.counters }

        IncrementAll ->
            { model | counters = Dict.map (\_ n -> n + 1) model.counters }

        DecrementAll ->
            { model | counters = Dict.map (\_ n -> n - 1) model.counters }



-- View


view : Model -> Html Msg
view model =
    main_ []
        [ h1 [] [ text "Twish" ]
        , div [ class "sum" ] [ text ("Sum: " ++ toString (List.sum (Dict.values model.counters))) ]
        , div [ class "counter" ]
            [ button [ onClick IncrementAll ] [ text "+" ]
            , button [ onClick DecrementAll ] [ text "-" ]
            ]
        , div [ class "counters" ]
            (List.map viewCounter (Dict.toList model.counters))
        ]


viewCounter : ( String, Int ) -> Html Msg
viewCounter ( thing, count ) =
    div [ class "counter" ]
        [ div [ class "title" ] [ text thing ]
        , button [ onClick (Increment thing) ] [ text "+" ]
        , text (toString count)
        , button [ onClick (Decrement thing) ] [ text "-" ]
        ]



-- Main


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }
