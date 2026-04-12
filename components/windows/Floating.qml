import QtQuick
import Quickshell
import qs.components
import qs.components.shapes
import qs.config

FloatingWindow {
    id: root
    implicitHeight: 400; implicitWidth: 400
    color: "transparent"

    default property alias contents: container.data

    RectBackground {
        anchors.fill: parent
    }

    Item {
        id: title
        anchors.top: parent.top
        height: 30
        width: root.width

        TextStyled {
            anchors.centerIn: parent
            text: "Settings"
        }
    }

    Item {
        id: box
        anchors.top: title.bottom
        height: root.height - title.height; width: root.width

        Item {
            id: container
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            clip: true
            height: parent.height - Global.padding.large
            width: parent.width - Global.padding.large
        }
    }
}