import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell.Services.Mpris
import qs.config
import qs.components.animations
import qs.components.shapes
import qs.components

RectForeground {
    id: root
    property int imageSize: 192
    property var activePlayer: {
        const players = Mpris.players.values
        for (let i = 0; i < players.length; i++) {
            if (players[i].playbackState === MprisPlaybackState.Playing)
                return players[i]
        }
        return null
    }

    Column {
        visible: activePlayer !== null
        anchors.centerIn: parent
        spacing: 10

        Item {
            id: box
            anchors.horizontalCenter: parent.horizontalCenter
            height: imageSize + 30; width: height

            Item {
                id: image
                anchors.centerIn: parent
                height: imageSize; width: height

                layer.enabled: true
                layer.effect: MultiEffect {
                    maskSource: Rectangle {
                        height: image.height; width: height
                        radius: height / 2
                    }
                }
                
                Image {
                    anchors.centerIn: parent
                    height: image.height; width: height
                    source: activePlayer?.trackArtUrl ?? ""
                    fillMode: Image.PreserveAspectCrop
                }
            }

            Shape {
                anchors.centerIn: image
                height: parent.width; width: height
                layer {
                    enabled: true
                    samples: 4
                }

                ShapePath {
                    strokeColor: Appearance.inactive
                    strokeWidth: 10
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap

                    PathAngleArc {
                        centerX: box.width / 2; centerY: box.height / 2
                        radiusX: imageSize / 2 + 10; radiusY: radiusX
                        startAngle: 90
                        sweepAngle: 360
                    }
                }
            }

            Shape {
                anchors.centerIn: image
                height: parent.width; width: height
                layer {
                    enabled: true
                    samples: 4
                }

                ShapePath {
                    strokeColor: Appearance.active
                    strokeWidth: 10
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap

                    PathAngleArc {
                        id: progressbar
                        centerX: box.width / 2; centerY: box.height / 2
                        radiusX: imageSize / 2 + 10; radiusY: radiusX
                        startAngle: 90
                        sweepAngle: 0
                        Behavior on sweepAngle { NumberAnim {} }
                    }
                }
            } 
        }


        TextStyledOwn { text: activePlayer?.trackTitle ?? "..." }
        TextStyledOwn { text: activePlayer?.trackArtist ?? "......" }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            Item {
                height: 40; width: 40
                TextStyledH {
                    anchors.centerIn: parent
                    text: "󰙤"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (activePlayer)
                            activePlayer.previous()
                    }
                }
            }

            Item {
                height: 40; width: 40
                TextStyledH {
                    anchors.centerIn: parent
                    text: activePlayer?.playbackState == MprisPlaybackState.Playing ? "" : ""
                }
                MouseArea {
                    anchors.fill: parent
                    // onClicked: {
                    //     if (activePlayer?.playbackState == MprisPlaybackState.Playing)
                    //         activePlayer.pause()
                    //     else
                    //         activePlayer.play()
                    // }
                }
            }

            Item {
                height: 40; width: 40
                TextStyledH {
                    anchors.centerIn: parent
                    text: "󰙢"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (activePlayer)
                            activePlayer.next()
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

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: if (activePlayer)
            progressbar.sweepAngle = 360 * (activePlayer.position / activePlayer.length)
    }
}