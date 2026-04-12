import QtQuick
import Quickshell.Wayland
import qs.components.shapes
import qs.components.controls
import qs.config
import qs.services

import Quickshell.Hyprland

RectForeground {
    id: root
    visible: ToplevelManager.toplevels.values.length > 0
    height: parent.height; width: programsRow.width

    Row {
        id: programsRow
        anchors.centerIn: parent
        spacing: 5
        leftPadding: 5; rightPadding: 5

        Repeater {
            model: ToplevelManager.toplevels
            delegate: ButtonIcon {
                source: modelData.appId
                height: root.height
                iconSize: root.height - Global.padding.mini * 2
                onClicked: modelData.activate()
                // onMidleClicked: modelData.close()
                active: modelData.activated
            }
        }
    }
}