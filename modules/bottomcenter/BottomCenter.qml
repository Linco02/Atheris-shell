import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.components.shapes

PanelWindow {
    id: root
    anchors {
        left: true
        bottom: true
        right: true
    }
    implicitHeight: 1
    exclusiveZone: -1
    color: "transparent"

    MouseArea {
        anchors.centerIn: parent
        height: root.height
        width: wallChoser.width / 2
        hoverEnabled: true
        onEntered: {
            popup.visible = true
            wallChoser.state = "open"
        }
    }

    focusable: popup.visible ? true : false

    PopupWindow {
        id: popup
        anchor {
            window: root
            rect.x: root.width / 2 - width / 2
            rect.y: - height - Appearance.padding.normal + root.height
        }
        implicitHeight: 168 + Appearance.padding.gigant
        implicitWidth: wallChoser.width
        color:  "transparent"
        visible: false

        Connections {
            target: wallChoser
            function onClose() {
                popup.visible = false
            }
        }

        WallpaperChoser { id: wallChoser }
    }
}