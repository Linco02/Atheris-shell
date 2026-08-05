import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.indicators
import qs.config
import qs.services

RectForeground {
    id: root
    property bool playerExist: SMris.playerExist
    property var playerActive: SMris.playerActive

    Column {
        anchors.centerIn: parent
        spacing: 10

        CircleProgres {
            anchors.horizontalCenter: parent.horizontalCenter
            height: root.width * 2 / 3
            progres: SMris.playerActiveProgres
            progresW: 10

            RectClip {
                anchors.centerIn: parent
                height: parent.height - parent.progresW * 2 - Style.padding.normal
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
                onClicked: SMris.previousMris(playerActive)
            }

            ButtonOwn {
                text: SMris.isplayerActivePlay ? "" : ""
                onClicked: {
                    if (SMris.isplayerActivePlay)
                        SMris.pauseMris(playerActive)
                    else SMris.playMris(playerActive)
                }
            }

            ButtonOwn {
                text: "󰙢"
                onClicked: SMris.nextMris(playerActive)
            }
        }
    }

    component ButtonOwn: Button {
        id: btn
        height: width; width: 40
        enabled: playerExist

        background: MouseFill {
            hoverEnabled: true
            onEntered: btnText.color = Theme.textAccent
            onExited: btnText.color = Theme.textSurface
        }

        contentItem: Item {
            anchors.fill: parent

            TextStyled {
                id: btnText
                anchors.centerIn: parent
                text: btn.text
                font.pixelSize: btn.height
            }
        }
    }

    component TextStyledOwn: TextStyled {
        width: root.width - Style.padding.large * 2
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }
}