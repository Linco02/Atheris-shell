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
        height: Style.padding.large; width: root.width

        TextStyled {
            anchors.centerIn: parent
            text: root.title
        }
    }

    Item {
        id: container
        anchors {
            top: name.bottom
            horizontalCenter: parent.horizontalCenter
        }
        height: root.height - Style.padding.large * 2
        width: root.width
        clip: true
    }

        // Item {
        //     id: box
        //     height: root.height - name.height - Style.padding.large * 2
        //     width: root.width - Style.padding.large * 2

        //     Item {
        //         id: container
        //         anchors {
        //             top: parent.top
        //             horizontalCenter: parent.horizontalCenter
        //         }
        //         clip: true
        //         height: parent.height - Style.padding.large
        //         width: parent.width - Style.padding.large
        //     }
        // }
    // }
}