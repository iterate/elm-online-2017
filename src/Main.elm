module Main exposing (..)

import Html exposing (Html, main_, header, h1, text, div, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


type alias Model =
    { counter1 : Int
    , counter2 : Int
    }


init : Model
init =
    { counter1 = 0
    , counter2 = 0
    }



-- Update


type Msg
    = Increment1
    | Decrement1
    | Increment2
    | Decrement2


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment1 ->
            { model | counter1 = model.counter1 + 1 }

        Decrement1 ->
            model - 1

        Increment2 ->

        Decrement2



-- View


view : Model -> Html Msg
view model =
    main_ []
        [ h1 [] [ text "Counter" ]
        , div [ class "counter" ]
            [ button [ onClick Increment1 ] [ text "+" ]
            , text (toString model)
            , button [ onClick Decrement1 ] [ text "-" ]
            ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }
