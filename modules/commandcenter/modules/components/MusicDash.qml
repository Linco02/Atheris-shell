import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.config
import qs.services
import qs.components.animations
import qs.components.indicators
import qs.components.shapes
import qs.components

RectForeground {
    id: root
    property bool playerExist: MrisServices.playerExist
    property var playerActive: MrisServices.playerActive

    Column {
        anchors.centerIn: parent
        spacing: 10

        CircleProgres {
            anchors.horizontalCenter: parent.horizontalCenter
            height: root.width * 2 / 3
            progres: MrisServices.playerActiveProgres
            progresW: 10

            RectClip {
                anchors.centerIn: parent
                height: parent.height - parent.progresW * 2 - Global.padding.normal
                width: height
                radius: height / 2

                Image {
                    anchors.fill: parent
                    source: playerExist ? playerActive.trackArtUrl : ""
                    fillMode: Image.PreserveAspectCrop
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
                onClicked: MrisServices.previousMris(playerActive)
            }

            ButtonOwn {
                text: MrisServices.isplayerActivePlay ? "" : ""
                onClicked: {
                    if (MrisServices.isplayerActivePlay)
                        MrisServices.pauseMris(playerActive)
                    else MrisServices.playMris(playerActive)
                }
            }

            ButtonOwn {
                text: "󰙢"
                onClicked: MrisServices.nextMris(playerActive)
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
        width: root.width - Global.padding.large * 2
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }
}