import QtQuick
import Quickshell
import Quickshell.Hyprland
import QtMultimedia
import qs.config
import qs.services
import qs.components.animations

Item {
    id: root
    anchors.fill: parent
    property bool wallpaperReady: false
    property string forwardSource: ""
    property string backSource: ""

    onWallpaperReadyChanged: {
        console.log(wallpaperReady)
        if (wallpaperReady)
            forward.state = ""
    }

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

    Connections {
        target: Wallpapers
        function onWallpaperChanged() {
            wallpaperReady = false

            if (backSource === "") {
                backSource = Wallpapers.wallpaper
                Palit.palitCreate(backSource)
            } else {
                if (Wallpapers.isWallpaperMpw) {
                    forwardSource = Wallpapers.wallpaperPlugMpw
                    Palit.palitCreate(forwardSource)
                } else {
                    forwardSource = Wallpapers.wallpaper
                    Palit.palitCreate(forwardSource)
                }
                forward.state = "change"
            }
        }
    }

    Item {
        id: back
        anchors.fill: parent

        Loader {
            anchors.fill: parent
            sourceComponent: {
                let type = Wallpapers.whatWallpaperFormat(backSource);
                if (type === "img") return imageComp;
                if (type === "anmf") return anmfComp;
                if (type === "video") return videoComp;
            }
        }

        // Зображення
        Component {
            id: imageComp
            Image {
                anchors.fill: parent
                source: backSource
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
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
                    if (status === AnimatedImage.Ready)
                        wallpaperReady = true
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
                    audioOutput: AudioOutput { muted: true } 
                    loops: MediaPlayer.Infinite
                    videoOutput: videoOutput
                    Component.onCompleted: mpwControler(player);
                    onPositionChanged: {
                        if (position > 0) {
                            wallpaperReady = true;
                        }
                    }
                }

                VideoOutput {
                    id: videoOutput
                    anchors.fill: parent
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

            PropertyAnim {
                properties: "opacity"
                duration: Appearance.durations.normal
            }

            onRunningChanged: {
                if(!running) {
                    backSource = null
                    backSource = Wallpapers.wallpaper
                    if (!Wallpapers.isWallpaperMpw)
                        forward.state = ""
                }
            }
        }

        Image {
            anchors.fill: parent
            source: forwardSource
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
        }

    }

    component Wall: Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }
}