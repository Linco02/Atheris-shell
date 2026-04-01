import QtQuick
import QtQuick.Controls
import Quickshell.Services.Mpris
import Quickshell.Widgets
import qs.config
import qs.services
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.components
import "../components"

Item {
    id: root
    implicitHeight: 500
    implicitWidth: musicPage.width

    property var player: MrisServices.player
    property bool playerExist: MrisServices.playerExist
    property int playerIndex: 0
    property var playerActive: playerExist ? player[playerIndex] : null

    Row {
        id: musicPage
        spacing: Appearance.padding.normal

        RectForeground {
            id: menuMusic
            height: root.height; width: 40

            Loader {
                anchors.fill: parent
                active: playerExist
                sourceComponent: ColumnNormal {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: Appearance.padding.normal
                    topPadding: Appearance.padding.small
                
                    Repeater {
                        model: player

                        ButtonSmall {
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: width; width: menuMusic.width - Appearance.padding.normal

                            onClicked: {
                                playerIndex = index
                                progressBar.value = playerActive?.position ?? 0
                            }

                            IconImage {
                                anchors.centerIn: parent
                                implicitSize: 16
                                source: AppIcons.getIcon(player[index].identity)
                            }
                        }
                    }
                }
            }
        }

        RectForeground {
            height: root.height; width: 500

            Column {
                anchors.centerIn: parent
                spacing: Appearance.padding.normal

                Item {
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 300; width: 300

                    CavaCircle {
                        anchors.fill: parent
                        property real innerRadius: imagePlayer.height / 2 + Appearance.padding.normal
                    }

                    ClippingWrapperRectangle {
                        id: imagePlayer
                        anchors.centerIn: parent
                        height: parent.height / 2; width: height
                        radius: height / 2

                        RectInactive {
                            anchors.fill: parent
                            Image {
                                anchors.fill: parent
                                source: playerActive?.trackArtUrl ?? ""
                                fillMode: Image.PreserveAspectCrop
                            }
                        }
                    }
                }

                Column {
                    TextStyledOwn { text: playerActive?.trackTitle ?? "..."}
                    TextStyledOwn { text: playerActive?.trackArtist ?? "..."}
                }

                SliderSmall {
                    id: progressBar
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 200
                    from: 0
                    to: playerActive?.length ?? 100
                    value: playerActive?.position ?? 0
                    enabled: playerExist

                    property var poss: 0

                    onMoved: {
                        if (positionChange.running) {
                            poss = value
                            positionChange.restart()
                        } else{
                            poss = value
                            positionChange.start()
                        }
                    }

                    Connections {
                        target: Tick1s
                        function onTick() {
                            if (playerExist && !progressBar.pressed)
                                progressBar.value = playerActive?.position
                        }
                    }

                    Timer {
                        id: positionChange
                        interval: 200
                        onTriggered: MrisServices.setPositionMris(playerActive, progressBar.poss)
                    }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: Appearance.padding.normal
                    
                    ButtonControl {
                        text: "󰙤"
                        onClicked: {
                            if (playerExist) {
                                MrisServices.previousMris(playerActive)
                                progressBar.value = playerActive?.position
                            }
                        }
                    }

                    ButtonControl {
                        text: isPlaying ? "" : ""

                        property bool isPlaying: playerActive?.playbackState == MprisPlaybackState.Playing ?? false

                        onClicked: {
                            if (playerExist) {
                                isPlaying ? MrisServices.pauseMris(playerActive) : MrisServices.playMris(playerActive)
                                progressBar.value = playerActive?.position
                            }
                        }
                    }

                    ButtonControl {
                        text: "󰙢"
                        onClicked: {
                            if (playerExist) {
                                MrisServices.nextMris(playerActive)
                                progressBar.value = playerActive?.position
                            }
                        }
                    }
                }
            }
        }

        RectForeground {
            id: menuVolume
            height: root.height; width: 40
        }
    }

    component ButtonControl: ButtonSmall {
        height: width; width: 50
        enabled: playerExist
    }

    component TextStyledOwn: TextStyled {
        width: root.width - Appearance.padding.large * 2
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }
}