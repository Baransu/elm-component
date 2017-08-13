module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Json.Encode as Encode
import Json.Decode as Decode


type Msg
    = Change Int


type alias Model =
    Int


model : Model
model =
    0


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change value ->
            ( model + value, Cmd.none )


view : Model -> Html Msg
view count =
    counter
        [ props
            [ ( "count", Encode.int count )
            ]
        , onChange Change
        ]
        []



-- custom event listener and decode, hidden behind library


onChange : (Int -> msg) -> Attribute msg
onChange tagger =
    on "change" (Decode.map tagger eventDetail)


eventDetail : Decode.Decoder Int
eventDetail =
    (Decode.field "detail" Decode.int)



-- wapper around custom component extracted to library


counter : List (Attribute msg) -> List (Html msg) -> Html msg
counter =
    node "elm-counter"



-- can be extracted to library


props : List ( String, Encode.Value ) -> Attribute msg
props =
    property "props" << Encode.object



-- boilerplate, one per application


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
