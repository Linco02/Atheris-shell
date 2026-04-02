import QtQuick
import Quickshell.Widgets
import qs.services
import qs.config
import qs.components.animations
import qs.components.shapes
import qs.components

RectForeground {
    id: root
    visible: false
    height: parent.height; width: 200

    property var playerActive: MrisServices.playerActive
    property bool playerExist: MrisServices.playerExist
    property bool isPlayerPlay: MrisServices.isplayerActivePlay

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
        x: Appearance.padding.small
        implicitSize: 16
        source: playerExist ? AppIcons.getIcon(playerActive.identity) : ""
    }

    RectClip {
        id: trackNameContainer
        height: parent.height
        width: root.width - programIcons.width - Appearance.padding.small * 3
        topLeftRadius: 0; bottomLeftRadius: 0
        x: programIcons.width + Appearance.padding.small * 2

        Row {
            id: trackNameRow
            anchors.verticalCenter: parent.verticalCenter
            spacing: Appearance.padding.gigant

            TextOwn {
                id: firstText
                onTextChanged: {
                    runningText.running = false
                    trackNameRow.x = 0
                    secondText.visible = firstText.width > trackNameContainer.width
                    runningText.running = firstText.width > trackNameContainer.width
                    
                }
            }

            TextOwn {
                id: secondText
                visible: firstText.width > trackNameContainer.width
            }

            SequentialAnimation on x {
                id: runningText
                running: firstText.width > trackNameContainer.width
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