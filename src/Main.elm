-- Model


module Main exposing (..)

import Dict exposing (Dict)
import Html exposing (Html, main_, header, h1, text, div, button, input, form)
import Html.Attributes exposing (class, value)
import Html.Events exposing (onClick, onInput, onSubmit)
import Http
import Json.Decode as Decode


type alias Model =
    { counters : Dict String Int
    , newThing : String
    }


getThings : Http.Request (Dict String Int)
getThings =
    Http.get "http://localhost:5000/counters" (Decode.dict Decode.int)


incThing : String -> Http.Request (Dict String Int)
incThing thing =
    Http.post ("http://localhost:5000/counters/" ++ thing ++ "/increment") Http.emptyBody (Decode.dict Decode.int)


decThing : String -> Http.Request (Dict String Int)
decThing thing =
    Http.post ("http://localhost:5000/counters/" ++ thing ++ "/decrement") Http.emptyBody (Decode.dict Decode.int)


init : ( Model, Cmd Msg )
init =
    { counters = Dict.empty
    , newThing = ""
    }
        ! [ Http.send ThingsLoaded getThings ]



-- Update


type Msg
    = Increment String
    | Decrement String
    | IncrementAll
    | DecrementAll
    | AddThing
    | NewThingInput String
    | ThingsLoaded (Result Http.Error (Dict String Int))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment thing ->
            { model | counters = Dict.update thing (Maybe.map (\c -> c + 1)) model.counters }
                ! [ Http.send ThingsLoaded (incThing thing) ]

        Decrement thing ->
            { model | counters = Dict.update thing (Maybe.map (\c -> c - 1)) model.counters }
                ! [ Http.send ThingsLoaded (decThing thing) ]

        IncrementAll ->
            { model | counters = Dict.map (\_ n -> n + 1) model.counters } ! []

        DecrementAll ->
            { model | counters = Dict.map (\_ n -> n - 1) model.counters } ! []

        AddThing ->
            { model | counters = Dict.insert model.newThing 0 model.counters, newThing = "" } ! []

        NewThingInput newThing ->
            { model | newThing = newThing } ! []

        ThingsLoaded (Ok counters) ->
            { model | counters = counters } ! []

        ThingsLoaded (Err err) ->
            Debug.crash ("Oooops: " ++ (toString err))



-- View


view : Model -> Html Msg
view model =
    main_ []
        [ h1 [] [ text "Counters" ]
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
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
