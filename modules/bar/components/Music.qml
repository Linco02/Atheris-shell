import QtQuick
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.animations
import qs.components.containers
import qs.config
import qs.services

RectForeground {
    id: root
    visible: false
    height: parent.height; width: musicContainer.width
    state: playerExist ? "open" : "close"

    property var playerActive: SMris.playerActive
    property bool playerExist: SMris.playerExist
    property bool isPlayerPlay: SMris.isplayerActivePlay

    RowStyled {
        id: musicContainer
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: Theme.padding.small; rightPadding: Theme.padding.small

        IconImage {
            id: programIcons
            anchors.verticalCenter: parent.verticalCenter
            x: Theme.padding.small
            implicitSize: 16
            source: playerExist ? SIcon.getIcon(playerActive.identity) : ""
        }

        Item {
            id: trackNameContainer
            height: parent.height
            width: runningName.textLength < 200 ? runningName.textLength : 200
            clip: true
            x: programIcons.width + Theme.padding.small * 2

            RunningText {
                id: runningName
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                text: playerActive.trackTitle || "..."
                runText: isPlayerPlay && textLength >= 200
            }

            TapHandler {onTapped: {SWManager.controlAtherisCenter("dashboard", "music")}}

            Behavior on width {NumberAnim {}}
        }

        ButtonTransparent {
            text: isPlayerPlay ? "" : ""
            onClicked: isPlayerPlay ? SMris.pauseMris(playerActive)
                : SMris.playMris(playerActive)
        }
    }

    states: [
        State {
            name: "close"
            PropertyChanges {
                target: root
                visible: false
                opacity: 0
                width: 0
            }
        },
        State {
            name: "open"
            PropertyChanges {
                target: root
                visible: true
                opacity: 1
                width: musicContainer.width
            }
        }
    ]

    transitions: [
        Transition {
            from: "close"; to: "open"
            ParallelAnimation {
                NumberAnim {property: "width"}
                NumberAnim {property: "opacity"}
            }
        },
        Transition {
            from: "open"; to: "close"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnim {property: "width"}
                    NumberAnim {property: "opacity"}
                }
                PropertyAction {
                    target: root
                    property: "visible"
                    value: false
                }
            }
        }
    ]
}