import QtQuick
import Quickshell
import qs.components.shapes

PopupWindow {
    anchor {
        window: root
        rect.y: root.height + 10
        rect.x: root.width - width - 10
    }
    implicitHeight: 600; implicitWidth: 300
    visible: true
    color: "red"

    RectForeground {
        height: 400; width: parent.width
        Column {
            anchors.horizontalCenter: parent.horizontalCenter

            Notifi { }
        }
    }
}