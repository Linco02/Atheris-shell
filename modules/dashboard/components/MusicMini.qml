import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.config
import qs.services
import qs.components.animations
import qs.components.shapes
import qs.components

RectForeground {
    id: root
    property int imageSize: 192
    property bool playerExist: MrisServices.playerExist
    property var playerActive: MrisServices.playerActive

    Column {
        anchors.centerIn: parent
        spacing: 10

        Item {
            id: box
            anchors.horizontalCenter: parent.horizontalCenter
            height: imageSize + 30; width: height

            ClippingWrapperRectangle {
                id: image
                anchors.centerIn: parent
                height: imageSize; width: height
                radius: height / 2

                Image {
                    id: img
                    anchors.fill: parent
                    source: playerExist ? playerActive.trackArtUrl : ""
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
                    strokeColor: Colors.inactive
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
                    strokeColor: Colors.active
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


        TextStyledOwn { text: playerExist ? playerActive.trackTitle : "..." }
        TextStyledOwn { text: playerExist ? playerActive.trackArtist : "..." }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            ButtonOwn {
                text: "󰙤"

                onClicked: {
                    MrisServices.previousMris(playerActive)
                    progressbar.sweepAngle = 360 * (playerActive.position / playerActive.length)
                }
            }

            ButtonOwn {
                text: MrisServices.isplayerActivePlay ? "" : ""

                onClicked: {
                    if (MrisServices.isplayerActivePlay)
                        MrisServices.pauseMris(playerActive)
                    else
                        MrisServices.playMris(playerActive)
                    progressbar.sweepAngle = 360 * (playerActive.position / playerActive.length)
                }
            }

            ButtonOwn {
                text: "󰙢"

                onClicked: {
                    MrisServices.nextMris(playerActive)
                    progressbar.sweepAngle = 360 * (playerActive.position / playerActive.length)
                }
            }
        }
    }

    component ButtonOwn: Button {
        id: btn
        height: width; width: 40
        enabled: playerExist

        background: MouseFill {
            hoverEnabled: true
            onEntered: btnText.color = Colors.textAccent
            onExited: btnText.color = Colors.textSurface
        }

        contentItem: Item {
            anchors.fill: parent

            TextStyled {
                id: btnText
                anchors.centerIn: parent
                text: btn.text
                font.pixelSize: btn.height

                Behavior on color { ColorAnim { } }
            }
        }
    }

    component TextStyledOwn: TextStyled {
        width: root.width - Appearance.padding.large * 2
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }

    Connections {
        target: Tick1s
        enabled: playerExist
        function onTick() {
            progressbar.sweepAngle = 360 * (playerActive.position / playerActive.length)
        }
    }
}