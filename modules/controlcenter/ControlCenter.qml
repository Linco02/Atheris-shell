import QtQuick
import Quickshell
import qs.config
import qs.components.shapes

PopupWindow {
    anchor {
        window: root
        rect.y: root.height + Appearance.padding.normal
        rect.x: root.width - width - Appearance.padding.normal
    }
    implicitHeight: 600; implicitWidth: 300
    visible: false
    // color: '#1f1869c5'
    color: "transparent"

    RectForeground {
        height: 400; width: parent.width
        border.width: 2
        border.color: Appearance.outline

        Column {
            anchors.fill: parent
            spacing: 10
            
            Services { }
            Notifi { }
        }
    }
}