import QtQuick
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.config
import qs.services

RectForeground {
    id: root

    property string name: ""
    property int load: 0
    property int empty: 0
    property real percent: 0

    Column {
        anchors.centerIn: parent

        TextStyled {
            id: diskName
            anchors.horizontalCenter: parent.horizontalCenter
            text: name
        }

        RowSpaced {
            anchors.horizontalCenter: parent.horizontalCenter

            TextStyled {
                anchors.verticalCenter: parent.verticalCenter
                text: load + "G"
            }

            RectInactive {
                anchors.verticalCenter: parent.verticalCenter
                height: root.height - diskName.height - Global.padding.normal
                width: root.width / 4 * 3

                RectActive {
                    anchors.left: parent.left
                    height: parent.height; width: parent.width * percent
                }
            }

            TextStyled {
                anchors.verticalCenter: parent.verticalCenter
                text: empty + "G"
            }
        }
    }
}