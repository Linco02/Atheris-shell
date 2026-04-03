import QtQuick
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.components.animations
import qs.config
import qs.services

RectForeground {
    id: root
    visible: false
    height: parent.height; width: 200

    property var playerActive: MrisServices.playerActive
    property bool playerExist: MrisServices.playerExist
    property bool isPlayerPlay: MrisServices.isplayerActivePlay
    property bool isTextFit: firstText.width > trackNameContainer.width

    onIsPlayerPlayChanged: {
        if (isPlayerPlay) {
            statusManager.state = "open"
        } else {
            statusManager.state = "close"
        }
    }

    Item {
        id: statusManager
        state: visible ? "open" : "close"

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
                    width: 200
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
    }

    IconImage {
        id: programIcons
        anchors.verticalCenter: parent.verticalCenter
        x: Global.padding.small
        implicitSize: 16
        source: playerExist ? AppIcons.getIcon(playerActive.identity) : ""
    }

    RectClip {
        id: trackNameContainer
        height: parent.height
        width: root.width - programIcons.width - Global.padding.small * 3
        topLeftRadius: 0; bottomLeftRadius: 0
        x: programIcons.width + Global.padding.small * 2

        Row {
            id: trackNameRow
            anchors.verticalCenter: parent.verticalCenter
            spacing: Global.padding.gigant

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
                running: isTextFit
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
    }

    component TextOwn: TextStyled {
        anchors.verticalCenter: parent.verticalCenter
        text: playerExist ? playerActive.trackTitle : "..."
    }
}