module Pages.List exposing (editBtn, list, maybeList, nav, playerRow, view)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Models exposing (Player)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Routing exposing (playerPath)


view : WebData (List Player) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb-2 text-white bg-black p-2" ]
        [ div [ class "left p-2" ] [ text "Players" ] ]


maybeList : WebData (List Player) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success players ->
            list players

        RemoteData.Failure error ->
            text "Error"


list : List Player -> Html Msg
list players =
    div [ class "p-2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Level" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map playerRow players)
            ]
        ]


playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text player.id ]
        , td [] [ text player.name ]
        , td [] [ text (String.fromInt player.level) ]
        , td []
            [ editBtn player ]
        ]


editBtn : Player -> Html.Html Msg
editBtn player =
    let
        path =
            playerPath player.id
    in
    a
        [ class "btn regular"
        , href path
        ]
        [ i [ class "fa fa-pencil mr-1" ] [], text "Edit" ]