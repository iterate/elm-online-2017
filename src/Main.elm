module Main exposing (..)

import Html exposing (Html, main_, header, h1, text)

type alias Model =
    Int

-- Update

type Msg
    = Increment
    | Decrement

update : Msg -> Model -> Model
update msg model =
    Debug.crash "TODO"

-- View

view : Model -> Html Msg
view model
    main_ [] []