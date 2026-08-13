import QtQuick
import Quickshell
import qs.components
import qs.components.shapes
import qs.config

FloatingWindow {
    id: root
    implicitHeight: 400; implicitWidth: 400
    color: Theme.surface

    default property alias contents: container.data

    Item {
        id: name
        anchors.top: parent.top
        height: 30; width: root.width

        TextStyled {
            anchors.centerIn: parent
            text: root.title
        }
    }

    Item {
        id: box
        anchors.top: name.bottom
        height: root.height - name.height; width: root.width

        Item {
            id: container
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            clip: true
            height: parent.height - Style.padding.large
            width: parent.width - Style.padding.large
        }
    }
}