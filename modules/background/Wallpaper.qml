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
    property string forwardSource: ""
    property string backSource: ""
    property string wallpaperfo

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
            // if (backSource === "") {
            //     backSource = Wallpapers.wallpaper
            // } else {
            //     forwardSource = Wallpapers.wallpaper
            //     forward.state = "change"
            // }
            backSource = null
            backSource = Wallpapers.wallpaper
            Palit.palitCreate(backSource)
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

        Component {
            id: imageComp
            Image {
                anchors.fill: parent
                source: backSource
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
            }
        }

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
            }
        }

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
                    backSource = forwardSource
                    forward.state = ""
                }
            }
        }

        // Зображення
        Loader {
            anchors.fill: parent
            active: Wallpapers.wallpaperFormat === "img"

            sourceComponent: Component {
                Image {
                    anchors.fill: parent
                    source: forwardSource
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                }
            }
        }
    }



    // GIF
    // Loader {
    //     anchors.fill: parent
    //     active: {
    //         let path = backSource.toString().toLowerCase();
    //         if (path.endsWith(".gif")) {
    //             return true;
    //         }
    //         return false;
    //     }

    //     sourceComponent: Component {
    //         AnimatedImage {
    //             anchors.fill: parent
    //             source: backSource
    //         }
    //     }
    // }


    // Wall {
    //     id: back
    // }

    // Wall {
    //     id: forward
    //     opacity: 0

    //     states: State {
    //         name: "change"

    //         PropertyChanges {
    //             target: forward
    //             opacity: 1
    //         }
    //     }

    //     transitions: Transition {
    //         from: ""; to: "change"
    //         PropertyAnim {
    //             properties: "opacity"
    //             duration: Appearance.durations.normal
    //         }
    //         onRunningChanged: {
    //             if(!running) {
    //                 back.source = forward.source
    //                 forward.state = ""
    //             }
    //         }
    //     }
    // }

    component Wall: Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }
}