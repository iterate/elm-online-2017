module Main exposing (..)

import Html exposing (Html, main_, header, h1, text, div, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


type alias Model =
    { counters : List Int
    }


init : Model
init =
    { counters = [ 0, 0, 0, 0, 0, 0, 0 ]
    }



-- Update


type Msg
    = Increment Int
    | Decrement Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment indexToChange ->
            { model | counter1 = model.counter1 + 1 }

        Decrement indexToChange ->
            { model | counter1 = model.counter1 - 1 }



-- View


view : Model -> Html Msg
view model =
    main_ []
        [ h1 [] [ text "Counter" ]
        , div [ class "counter" ]
            [ button [ onClick (Increment 0) ] [ text "+" ]
            , text (toString model.counter1)
            , button [ onClick (Decrement 0) ] [ text "-" ]
            ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }
