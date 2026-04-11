import QtQuick
import QtMultimedia
import Quickshell
import qs.components
import qs.components.shapes
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

    RectClip {
        id: forward
        anchors.centerIn: parent
        opacity: 0
        height: width; width: 0
        radius: width / 2

        states: State {
            name: "change"

            PropertyChanges {
                target: forward
                opacity: 1
                width: root.width * 1.5
            }
        }

        transitions: Transition {
            from: ""; to: "change"

            NumberAnim { properties: "width"; duration: Global.durations.slow }

            onRunningChanged: {
                if(!running) {
                    backSource = null
                    backSource = WallpaperService.wallpaper
                    animationEnd = true
                }

                wallpaperSwith()
            }
        }

        Image {
            anchors.centerIn: parent
            height: root.height; width: root.width
            fillMode: Image.PreserveAspectCrop
            source: forwardSource
            asynchronous: true
        }
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
}