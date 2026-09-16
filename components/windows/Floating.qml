import QtQuick
import Quickshell
import qs.components
import qs.components.shapes
import qs.config

FloatingWindow {
    id: root
    implicitHeight: 400; implicitWidth: 400
    color: Theme.colors.surface

    default property alias contents: container.data

    Item {
        id: name
        height: Theme.padding.large; width: root.width

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
        height: root.height - Theme.padding.large * 2
        width: root.width
        clip: true
    }

        // Item {
        //     id: box
        //     height: root.height - name.height - Theme.padding.large * 2
        //     width: root.width - Theme.padding.large * 2

        //     Item {
        //         id: container
        //         anchors {
        //             top: parent.top
        //             horizontalCenter: parent.horizontalCenter
        //         }
        //         clip: true
        //         height: parent.height - Theme.padding.large
        //         width: parent.width - Theme.padding.large
        //     }
        // }
    // }
}