import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.indicators
import qs.config
import qs.services

RectForeground {
    id: root
    property bool playerExist: SAudio.playerExist
    property var playerActive: SAudio.playerActive

    Column {
        anchors.centerIn: parent
        spacing: 10

        CircleProgres {
            anchors.horizontalCenter: parent.horizontalCenter
            height: root.width * 2 / 3
            progres: SAudio.playerActiveProgres
            progresW: 10

            RectClip {
                anchors.centerIn: parent
                height: parent.height - parent.progresW * 2 - Theme.padding.normal
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

            ButtonStyled {
                text: "󰙤"
                onClicked: SAudio.previous(playerActive)
            }

            ButtonStyled {
                text: SAudio.isplayerActivePlay ? "" : ""
                onClicked: {
                    if (SAudio.isplayerActivePlay)
                        SAudio.pause(playerActive)
                    else SAudio.play(playerActive)
                }
            }

            ButtonStyled {
                text: "󰙢"
                onClicked: SAudio.next(playerActive)
            }
        }
    }

    component TextStyledOwn: TextStyled {
        width: root.width - Theme.padding.large * 2
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }
}