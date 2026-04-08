import QtQuick
import Quickshell.Services.UPower
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.config
import qs.services

RectForeground {
    id: root
    height: parent.height; width: bluetoothContainer.width + Global.padding.large

    SpacedRow {
        id: bluetoothContainer
        height: parent.height
        anchors.centerIn: parent

        TextStyledH {
            anchors.verticalCenter: parent.verticalCenter
            text: "󰂯" // 󰂰 󰂲
        }
    }
}