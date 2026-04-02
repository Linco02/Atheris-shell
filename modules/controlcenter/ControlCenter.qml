import QtQuick
import Quickshell
import qs.config
import qs.components.shapes
import qs.services

PopFlash {
    anchor {
        window: root
        rect.y: root.height + Appearance.padding.normal
        rect.x: root.width - width - Appearance.padding.normal
    }
    implicitHeight: 900; implicitWidth: 700

    property bool isLeft: false

    Item {
        // anchors.horizontalCenter: parent.horizontalCenter
        // y: Appearance.padding.large
        height: 500 - Appearance.padding.large * 2
        width: 400 - Appearance.padding.large * 2

        Column {
            anchors.fill: parent
            spacing: Appearance.padding.normal
            
            Info { }
            Services {
                panelH: root.height
                panelW: root.width
            }
            Notifi {
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}