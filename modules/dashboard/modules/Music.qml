import QtQuick
import QtQuick.Controls
import Quickshell.Services.Mpris
import Quickshell.Widgets
import qs.config
import qs.services
import qs.components.shapes
import qs.components.controls
import qs.components
import "../components"

Item {
    id: root
    implicitHeight: musicPage.height
    implicitWidth: musicPage.width

    Item {
        id: musicPage
        anchors.centerIn: parent
        implicitHeight: 500
        implicitWidth: playersContainer.width

        Column {
            id: playersContainer
            spacing: Appearance.padding.normal

            CavaBar {}

            Repeater {
                model: Mpris.players
                delegate: RectForeground {
                    height: 400; width: 500

                    Column {
                        anchors.centerIn: parent
                        spacing: Appearance.padding.normal

                        ClippingWrapperRectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 200; width: height
                            radius: height / 2

                            RectInactive {
                                anchors.fill: parent

                                Image {
                                    anchors.fill: parent
                                    source: modelData.trackArtUrl ?? ""
                                    fillMode: Image.PreserveAspectCrop
                                }
                            }
                        }

                        Column {
                            TextStyledOwn { text: modelData.trackTitle ?? "..." }
                            TextStyledOwn { text: modelData.trackArtist ?? "......" }
                        }

                        SliderSmall {
                            id: progressBar
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 200
                            from: 0
                            to: modelData.length
                            value: modelData.position
                            onMoved: MrisServices.setPositionMris(modelData, value)

                            Connections {
                                target: Tick1s
                                function onTick() {
                                    if (!progressBar.pressed)
                                        progressBar.value = modelData.position
                                }
                            }
                        }

                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: Appearance.padding.normal
                            
                            ButtonSmall {
                                text: "󰙤"
                                onClicked: {
                                    MrisServices.previousMris(modelData)
                                    progressBar.value = modelData.position
                                }
                            }

                            ButtonSmall {
                                property bool isPlaying: modelData.playbackState == MprisPlaybackState.Playing

                                text: isPlaying ? "" : ""
                                onClicked: {
                                    isPlaying ? MrisServices.pauseMris(modelData) : MrisServices.playMris(modelData)
                                    progressBar.value = modelData.position
                                }
                            }

                            ButtonSmall {
                                text: "󰙢"
                                onClicked: {
                                    MrisServices.nextMris(modelData)
                                    progressBar.value = modelData.position
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    component TextStyledOwn: TextStyled {
        width: root.width - Appearance.padding.large * 2
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }
}