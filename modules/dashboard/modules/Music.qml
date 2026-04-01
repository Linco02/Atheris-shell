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

    property var player: Mpris.players.values
    property var playerNow: MrisServices.playerNow
    property bool cavaOn: MrisServices.playeNowIsPlay

    Row {
        id: musicPage
        spacing: Appearance.padding.normal

        RectForeground {
            id: menuMusic
            height: root.height; width: 40

            ColumnNormal {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Appearance.padding.normal
                topPadding: Appearance.padding.small

                Repeater {
                    model: player

                    ButtonSmall {
                        height: width; width: menuMusic.width - Appearance.padding.normal
                        text: index
                        onClicked: {
                            MrisServices.playerChose = index
                            progressBar.value = playerNow.position
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
                        property bool widgetOn: cavaOn
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
                                source: MrisServices.playerIcon
                                fillMode: Image.PreserveAspectCrop
                            }
                        }
                    }
                }

                Column {
                    TextStyledOwn { text: playerNow.trackTitle ?? "..." }
                    TextStyledOwn { text: playerNow.trackArtist ?? "......" }
                }

                SliderSmall {
                    id: progressBar
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 200
                    from: 0
                    to: playerNow.length
                    value: playerNow.position
                    onMoved: MrisServices.setPositionMris(playerNow, value)

                    // Connections {
                    //     target: Tick1s
                    //     function onTick() {
                    //         if (!progressBar.pressed)
                    //             progressBar.value = playerNow.position
                    //     }
                    // }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: Appearance.padding.normal
                    
                    ButtonSmall {
                        height: width; width: 50
                        text: "󰙤"
                        onClicked: {
                            MrisServices.previousMris(playerNow)
                            progressBar.value = playerNow.position
                        }
                    }

                    ButtonSmall {
                        height: width; width: 50
                        text: isPlaying ? "" : ""

                        property bool isPlaying: playerNow.playbackState == MprisPlaybackState.Playing

                        onClicked: {
                            isPlaying ? MrisServices.pauseMris(playerNow) : MrisServices.playMris(playerNow)
                            progressBar.value = playerNow.position
                        }
                    }

                    ButtonSmall {
                        height: width; width: 50
                        text: "󰙢"
                        onClicked: {
                            MrisServices.nextMris(playerNow)
                            progressBar.value = playerNow.position
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

    component TextStyledOwn: TextStyled {
        width: root.width - Appearance.padding.large * 2
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }
}