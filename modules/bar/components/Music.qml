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
    property bool isTextFit: firstText.width > trackNameContainer.width

    RowStyled {
        id: musicContainer
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: Style.padding.small; rightPadding: Style.padding.small

        IconImage {
            id: programIcons
            anchors.verticalCenter: parent.verticalCenter
            x: Style.padding.small
            implicitSize: 16
            source: playerExist ? SAppIcons.getIcon(playerActive.identity) : ""
        }

        Item {
            id: trackNameContainer
            height: parent.height
            width: trackNameRow.width < 200 ? trackNameRow.width : 200
            clip: true
            x: programIcons.width + Style.padding.small * 2

            Row {
                id: trackNameRow
                anchors.verticalCenter: parent.verticalCenter
                spacing: Style.padding.gigant

                TextOwn {
                    id: firstText
                    onTextChanged: { trackNameRow.x = 0 }
                }

                TextOwn {
                    id: secondText
                    visible: isTextFit
                }

                SequentialAnimation on x {
                    id: runningText
                    running: isTextFit && isPlayerPlay
                    loops: Animation.Infinite

                    PauseAnimation { duration: 5000 }

                    NumberAnim {
                        from: 0
                        to: - (firstText.width + trackNameRow.spacing)
                        easing.type: Easing.Linear
                        duration: 10000
                    }
                }
            }

            TapHandler {
                onTapped: {
                    UIState.dashboardModul = "music"
                    UIState.commandCenterModule = "dashboard"
                    UIState.isCommandCenterOpen = !UIState.isCommandCenterOpen
                }
            }

            Behavior on width { NumberAnim { } }
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
                NumberAnim { property: "width" }
                NumberAnim { property: "opacity" }
            }
        },
        Transition {
            from: "open"; to: "close"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnim { property: "width" }
                    NumberAnim { property: "opacity" }
                }
                PropertyAction {
                    target: root
                    property: "visible"
                    value: false
                }
            }
        }
    ]

    component TextOwn: TextStyled {
        anchors.verticalCenter: parent.verticalCenter
        text: playerExist ? playerActive.trackTitle : "..."
    }
}