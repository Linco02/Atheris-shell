import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services
import "./components"

Item {
    id: root
    height: 500; width: musicContainer.width

    property var player: MrisServices.player
    property bool playerExist: MrisServices.playerExist
    property int playerIndex: 0
    property var playerActive: playerExist ? player[playerIndex] : null

    RowSpaced {
        id: musicContainer

        RectForeground {
            id: menuMusic
            height: root.height; width: 40

            SpacedColumn {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Global.padding.normal
                topPadding: Global.padding.normal

                Repeater {
                    model: player
                    delegate: ButtonIcon {
                        height: width; width: menuMusic.width / 2
                        iconSize: height
                        source: modelData.identity
                        onLeftClicked: {
                            playerIndex = index
                            progressBar.value = playerActive?.position ?? 0
                        }
                    }
                }
            }
        }

        RectForeground {
            id: music
            height: root.height; width: 400

            Column {
                anchors.centerIn: parent
                spacing: Global.padding.normal

                RadialBars {
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: music.height / 3 * 2; width: height
                    innerRadius: height / 4 + Global.padding.normal
                
                    RectClip {
                        anchors.centerIn: parent
                        height: parent.height / 2; width: height
                        radius: height / 2

                        RectInactive {
                            anchors.fill: parent

                            Image {
                                anchors.fill: parent
                                source: playerExist ? playerActive.trackArtUrl : ""
                                fillMode: Image.PreserveAspectCrop
                            }
                        }
                    }
                }

                Column {
                    TextOwn { text: playerActive?.trackTitle ?? "..."}
                    TextOwn { text: playerActive?.trackArtist ?? "..."}
                }

                SliderStyled {
                    id: progressBar
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 200
                    from: 0
                    to: playerActive?.length ?? 100
                    value: playerActive?.position ?? 0
                    enabled: playerExist

                    property var poss: 0

                    onMoved: MrisServices.setPositionMris(playerActive, value)

                    Connections {
                        target: Tick1s
                        function onTick() {
                            if (playerExist && !progressBar.pressed)
                                progressBar.value = playerActive?.position
                        }
                    }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: Global.padding.normal
                    
                    ButtonOwn {
                        text: "󰙤"
                        onLeftClicked: {
                            if (playerExist) {
                                MrisServices.previousMris(playerActive)
                                progressBar.value = playerActive?.position
                            }
                        }
                    }

                    ButtonOwn {
                        text: isPlaying ? "" : ""

                        property bool isPlaying: MrisServices.checkIsPlaying(playerActive)

                        onLeftClicked: {
                            if (playerExist) {
                                isPlaying ? MrisServices.pauseMris(playerActive) : MrisServices.playMris(playerActive)
                                progressBar.value = playerActive?.position
                            }
                        }
                    }

                    ButtonOwn {
                        text: "󰙢"
                        onLeftClicked: {
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


    component ButtonOwn: ButtonStyled {
        height: 50; width: height
        enabled: playerExist
    }

    component TextOwn: TextStyled {
        width: root.width - Global.padding.large * 2
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }
}