-- Model


module Main exposing (..)

import Dict exposing (Dict)
import Html exposing (Html, main_, header, h1, text, div, button, input, form)
import Html.Attributes exposing (class, value)
import Html.Events exposing (onClick, onInput, onSubmit)


type alias Model =
    { counters : Dict String Int
    , newThing : String
    }


init : Model
init =
    { counters =
        Dict.fromList
            [ ( "Knapper", 0 )
            , ( "Glansbilder", 0 )
            , ( "Kroner", 0 )
            ]
    , newThing = ""
    }



-- Update


type Msg
    = Increment String
    | Decrement String
    | IncrementAll
    | DecrementAll
    | AddThing
    | NewThingInput String


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

        AddThing ->
            { model | counters = Dict.insert model.newThing 0 model.counters, newThing = "" }

        NewThingInput newThing ->
            { model | newThing = newThing }



-- View


view : Model -> Html Msg
view model =
    main_ []
        [ h1 [] [ text "Twish" ]
        , form [ class "new", onSubmit AddThing ] [ input [ value model.newThing, onInput NewThingInput ] [], button [] [ text "Legg til" ] ]
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
