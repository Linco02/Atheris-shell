import QtQuick
import Quickshell
import qs.config
import qs.services
import qs.components.animations

Item {
    anchors.fill: parent

    Connections {
        target: Appearance
        function onWallpaperChanged() {
            if (back.source == "") {
                back.source = Appearance.wallpaper
            } else {
                forward.source = Appearance.wallpaper
                forward.state = "change"
            }
        }
    }

    Wall {
        id: back
    }

    Wall {
        id: forward
        scale: 0

        states: State {
            name: "change"

            PropertyChanges {
                target: forward
                scale: 1
            }
        }

        transitions: Transition {
            from: ""; to: "change"
            PropertyAnim {
                properties: "scale"
                duration: Appearance.durations.slow
            }
            onRunningChanged: {
                if(!running) {
                    back.source = forward.source
                    forward.state = ""
                }
            }
        }
    }

    component Wall: Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }
}