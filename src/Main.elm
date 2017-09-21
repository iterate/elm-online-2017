-- Model


module Main exposing (..)

import Html exposing (Html, main_, header, h1, text, div, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


type alias Model =
    Int


init : Model
init =
    0



-- Update


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- View


view : Model -> Html Msg
view model =
    main_ []
        [ h1 [] [ text "Counter" ]
        , div [ class "counter" ]
            [ button [ onClick Increment ] [ text "+" ]
            , text (toString model)
            , button [ onClick Decrement ] [ text "-" ]
            ]
        ]



-- Main


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }
