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

    property var player: MrisServices.playerNow
    property bool isPlay: MrisServices.playeNowIsPlay

    onIsPlayChanged: {
        if (isPlay) {
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
                    visible: true
                    opacity: 0
                    width: 0
                }
            },

            State {
                name: "open"
                PropertyChanges {
                    target: root
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
        source: AppIcons.getIcon(player.identity)
    }

    RectClip {
        height: parent.height
        width: root.width - programIcons.width - Appearance.padding.small * 3
        x: programIcons.width + Appearance.padding.small * 2

        TextStyled {
            anchors.verticalCenter: parent.verticalCenter
            x: Appearance.padding.small
            text: player.trackTitle ?? "..."
        }
    }

    Component.onCompleted: {
        visible = MrisServices.playerNow
    }
}