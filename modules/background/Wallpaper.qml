import QtQuick
import QtMultimedia
import Quickshell
import qs.components
import qs.components.animations
import qs.config
import qs.services

Item {
    id: root
    anchors.fill: parent

    property string forwardSource: ""
    property string backSource: ""
    property bool wallpaperReady: false
    property bool animationEnd: false

    function wallpaperSwith() {
        if (wallpaperReady && animationEnd) {
            wallpaperReady = false
            animationEnd = false
            forward.state = ""
        }
    }

    SmartView {
        anchors.fill: parent
        content: backSource
        isPlay: WallpaperService.isDesktopEmpty
        onContentReady: {
            wallpaperReady = true
            wallpaperSwith()
        }
    }

    Item {
        id: forward
        anchors.fill: parent
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

            PropertyAnim { properties: "opacity" }

            onRunningChanged: {
                if(!running) {
                    backSource = null
                    backSource = WallpaperService.wallpaper
                    animationEnd = true
                }

                wallpaperSwith()
            }
        }

        Wall { source: forwardSource }
    }

    Connections {
        target: WallpaperService
        function onWallpaperChanged() {
            wallpaperReady = false

            let source = WallpaperService.isWallpaperAnimated
                ? WallpaperService.wallpaperFrame
                : WallpaperService.wallpaper

            if (backSource === "") {
                backSource = WallpaperService.wallpaper
            } else {
                forwardSource = source
                forward.state = "change"
            }
            
            PalitServices.palitCreate(source)
        }
    }

    component Wall: Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }
}