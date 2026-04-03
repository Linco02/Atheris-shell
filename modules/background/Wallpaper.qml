import QtQuick
import QtMultimedia
import Quickshell
import qs.config
import qs.components.animations
import qs.services

Item {
    id: root
    anchors.fill: parent
    
    property bool wallpaperReady: false
    property bool animationEnd: false
    property string forwardSource: ""
    property string backSource: ""

    function mpwControler(player) {
        if (WallpaperService.isWallPlay) {
            player.play()
        } else {
            player.pause()
        }
    }

    function wallpaperSwith() {
        if (wallpaperReady && animationEnd) {
            wallpaperReady = false
            animationEnd = false
            forward.state = ""
        }
    }

    Item {
        id: back
        anchors.fill: parent

        Loader {
            anchors.fill: parent
            sourceComponent: {
                let type = WallpaperService.wallpaperFormat(backSource);
                if (type === "img") return imageComp;
                if (type === "anmf") return anmfComp;
                if (type === "video") return videoComp;
            }
        }

        // Зображення
        Component {
            id: imageComp
            Wall {
                source: backSource

                onStatusChanged: {
                    if (Image.Ready) {
                        wallpaperReady = true
                        wallpaperSwith()
                    }
                }
            }
        }

        // Анімовані зображення
        Component {
            id: anmfComp
            AnimatedImage {
                anchors.fill: parent
                source: backSource
                playing: isWallPlay

                property int frame: 0
                onPlayingChanged: {
                    if (!playing)
                        frame = currentFrame
                    else
                        currentFrame = frame
                }
                onStatusChanged: {
                    if (status === AnimatedImage.Ready) {
                        wallpaperReady = true
                        wallpaperSwith()
                    }
                }
            }
        }

        // Відео
        Component {
            id: videoComp
            Item {
                anchors.fill: parent

                MediaPlayer {
                    id: player
                    source: backSource
                    loops: MediaPlayer.Infinite
                    videoOutput: videoOutput
                    Component.onCompleted: mpwControler(player)
                }

                VideoOutput {
                    id: videoOutput
                    anchors.fill: parent
                    onSourceRectChanged: {
                        wallpaperReady = true
                        wallpaperSwith()
                    }
                }

                Connections {
                    target: WallpaperService
                    function onIsWallPlayChanged() {
                        mpwControler(player);
                    }
                }
            }
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

            let source = WallpaperService.isWallpaperMpw
                ? WallpaperService.wallpaperPlugMpw
                : WallpaperService.wallpaper

            if (backSource === "") {
                backSource = WallpaperService.wallpaper
            } else {
                forwardSource = source
                forward.state = "change"
            }
            
            Palit.palitCreate(source)
        }
    }

    component Wall: Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }
}