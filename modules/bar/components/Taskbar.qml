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
    height: isHorizontal ? barWidth - Theme.stock.small : (barWidth - Theme.stock.small) * count
    width: isHorizontal ? (barWidth - Theme.stock.small) * count : barWidth - Theme.stock.small

    property bool isHorizontal: true
    property int barWidth: Theme.barWidth
    property int count: ToplevelManager.toplevels.values.length

    ListView {
        id: taskbarContainer
        anchors.fill: parent
        orientation: isHorizontal ? ListView.Horizontal : ListView.Vertical
        interactive: false

        model: ToplevelManager.toplevels
        delegate: ButtonIcon {
            source: modelData.appId
            height: isHorizontal ? root.height : root.width
            iconSize: height - Theme.padding.small
            onClicked: modelData.activate()
            active: modelData.activated
        }
    }
}