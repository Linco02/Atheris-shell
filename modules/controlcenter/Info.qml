import QtQuick
import qs.config
import qs.components.shapes
import qs.components

Item {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter
    height: 26
    width: parent.width - Appearance.padding.large * 2

    Item {
        anchors.fill: parent

        TextStyledH {
            anchors.left: parent.left
            text: "Up 16h25m"
        }

        Row {
            anchors.right: parent.right
            height: root.height
            spacing: 10

            TextStyledH {
                text: "󰂚"
            }

            TextStyledH {
                text: ""
            }

            TextStyledH {
                text: ""
            }
        }
    }
}