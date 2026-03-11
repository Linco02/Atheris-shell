import QtQuick
import Quickshell
import qs.config
import qs.services
import qs.components.animations

Item {
    anchors.fill: parent

    Connections {
        target: Wallpapers
        function onWallpaperChanged() {
            if (back.source == "") {
                back.source = Wallpapers.wallpaper
            } else {
                forward.source = Wallpapers.wallpaper
                forward.state = "change"
            }
        }
    }

    Wall {
        id: back
    }

    Wall {
        id: forward
        opacity: 0

        states: State {
            name: "change"

            PropertyChanges {
                target: forward
                opacity: 1
            }
        }

        transitions: Transition {
            from: ""; to: "change"
            PropertyAnim {
                properties: "opacity"
                duration: Appearance.durations.normal
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