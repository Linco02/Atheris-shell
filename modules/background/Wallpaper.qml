import QtQuick
import Quickshell
import Quickshell.Hyprland
import QtMultimedia
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

    property bool isWallPlay: {
        const activeWs = Hyprland.focusedWorkspace

        if (!activeWs) return true
        return !Hyprland.toplevels.values.some(tl => tl.workspace && tl.workspace.id === activeWs.id)
    }

    function mpwControler(player) {
        if (isWallPlay) {
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

    Connections {
        target: Wallpapers
        function onWallpaperChanged() {
            wallpaperReady = false

            let source = Wallpapers.isWallpaperMpw
                ? Wallpapers.wallpaperPlugMpw
                : Wallpapers.wallpaper

            if (backSource === "") {
                backSource = Wallpapers.wallpaper
            } else {
                forwardSource = source
                forward.state = "change"
            }
            
            Palit.palitCreate(source)
        }
    }

    Item {
        id: back
        anchors.fill: parent

        Loader {
            anchors.fill: parent
            sourceComponent: {
                let type = Wallpapers.wallpaperFormat(backSource);
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
                    target: root
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
                    backSource = Wallpapers.wallpaper
                    animationEnd = true
                }

                wallpaperSwith()
            }
        }

        Wall { source: forwardSource }
    }

    component Wall: Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }
}