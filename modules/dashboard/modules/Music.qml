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

        ScrollView {
            anchors.fill: parent
            contentWidth: -1
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            Column {
                id: playersContainer
                spacing: Appearance.padding.normal

                Repeater {
                    model: Mpris.players
                    delegate: RectForeground {
                        height: 600; width: 600

                        Column {
                            anchors.horizontalCenter: parent.horizontalCenter
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
                                            source: modelData.trackArtUrl ?? ""
                                            fillMode: Image.PreserveAspectCrop
                                        }
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
    }

    component TextStyledOwn: TextStyled {
        width: root.width - Appearance.padding.large * 2
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }
}