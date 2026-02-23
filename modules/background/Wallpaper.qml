import QtQuick
import Quickshell
import qs.config
import qs.services
import qs.components.animations

Item {
    anchors.fill: parent

    property var currentWall: ""


    function wallpaperRandom() {
        const choseWall = Math.floor(Math.random() * Wallpapers.wallparersList.length)
        if(currentWall === Wallpapers.wallparersList[choseWall]) {
            wallpaperRandom()
        } else {
            currentWall = Wallpapers.wallparersList[choseWall]
        }
    }

    onCurrentWallChanged: {
        if (back.source == "") {
            back.source = currentWall
        } else {
            forward.source = currentWall
            forward.state = "change"
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

    Connections {
        target: Wallpapers
        function onWallpaperReady() {
            wallpaperRandom()
        }
    }

    
    MouseArea {
        anchors.fill: parent
        onClicked: wallpaperRandom()
    }
}