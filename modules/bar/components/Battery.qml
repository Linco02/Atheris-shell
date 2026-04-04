import QtQuick
import Quickshell.Services.UPower
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.config
import qs.services

RectForeground {
    id: root
    visible: UPowerServices.isExist
    height: parent.height; width: batteryContainer.width + Global.padding.large

    readonly property real batteryLevel: UPowerServices.batteryLevel
    readonly property real batteryStatus: UPowerServices.batteryStatus
    readonly property string status: UPowerServices.status

    SpacedRow {
        id: batteryContainer
        height: parent.height
        anchors.centerIn: parent

        TextStyledH {
            text: (batteryLevel * 100) + "%"
        }

        TextStyledH {
            anchors.verticalCenter: parent.verticalCenter
            id: batterySymbol
            rotation: 90
            text: UPowerServices.batteryIcon
        }
    }
}