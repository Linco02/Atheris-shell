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
    width: programsRow.width

    Row {
        id: programsRow
        anchors.horizontalCenter: parent.horizontalCenter
        leftPadding: (!Theme.theme.useAngledShapes ? Theme.padding.small * 2: 0)
        rightPadding: leftPadding

        Repeater {
            model: ToplevelManager.toplevels
            delegate: ButtonIcon {
                source: modelData.appId
                height: root.height
                iconSize: root.height - Theme.padding.small
                onClicked: modelData.activate()
                active: modelData.activated
            }
        }
    }
}