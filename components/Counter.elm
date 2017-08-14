-- @elm-component elm-counter


port module Counter exposing (main)

import Html exposing (..)
import Html.Events exposing (..)


type Msg
    = SetCount Int
    | Change Int


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )


port count : (Model -> msg) -> Sub msg


port event : ( String, Model ) -> Cmd msg


fireEvent : String -> Model -> Cmd msg
fireEvent eventType payload =
    event ( eventType, payload )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCount count ->
            ( count, Cmd.none )

        Change value ->
            ( model, fireEvent "change" value )


view : Model -> Html Msg
view count =
    div
        []
        [ button [ onClick (Change 1) ] [ text "+" ]
        , text ("Value: " ++ toString count)
        , button [ onClick (Change -1) ] [ text "-" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ count SetCount
        ]



-- boilerplate


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
