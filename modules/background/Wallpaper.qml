import QtQuick
import QtMultimedia
import Quickshell
import qs.config
import qs.services
import qs.components
import qs.components.shapes
import qs.components.animations

Item {
    id: root
    anchors.fill: parent

    property string forwardSource: ""
    property string backSource: ""
    property bool wallpaperReady: false
    property bool animationEnd: false

    function wallpaperSwitch() {
        wallpaperReady = false

        let source = SWallpaper.isWallpaperAnimated
            ? SWallpaper.wallpaperThumbnail
            : SWallpaper.wallpaper

        if (backSource === "") {
            backSource = SWallpaper.wallpaper
        } else {
            forwardSource = source
            forward.state = "change"
        }
        
        // PalitServices.palitCreate(source)
    }

    function removeThumbnail() {
        if (wallpaperReady && animationEnd) {
            wallpaperReady = false
            animationEnd = false
            forward.state = ""
        }
    }

    SmartView {
        anchors.fill: parent
        content: backSource
        isPlay: SWallpaper.isDesktopEmpty
        onContentReady: {
            wallpaperReady = true
            removeThumbnail()
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

            NumberAnim { properties: "width"; duration: Style.durations.slow }

            onRunningChanged: {
                if(!running) {
                    backSource = null
                    backSource = SWallpaper.wallpaper
                    animationEnd = true
                }

                removeThumbnail()
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
        target: SWallpaper
        function onWallpaperChanged() {
            if (SWallpaper.wallpaper) wallpaperSwitch()
        }
    }
}