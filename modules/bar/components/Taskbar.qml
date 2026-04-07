import QtQuick
import Quickshell.Wayland
import qs.components.shapes
import qs.components.controls
import qs.config
import qs.services

import Quickshell.Hyprland

RectForeground {
    id: root
    height: parent.height; width: programsRow.width

    Row {
        id: programsRow
        anchors.centerIn: parent

        Repeater {
            model: ToplevelManager.toplevels
            delegate: ButtonIcon {
                height: root.height
                source: modelData.appId
                onLeftClicked: modelData.activate()
                onMidleClicked: modelData.close()
                occupied: modelData.activated
            }
        }
    }
}