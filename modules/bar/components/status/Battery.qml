import QtQuick
import Quickshell.Services.UPower
import qs.components
import qs.services

Loader {
    active: UPower.displayDevice.isPresent

    sourceComponent: Item {
        height: parent.height; width: batteryRow.width

        readonly property real batteryLevel: UPowerServices.batteryLevel
        readonly property real batteryStatus: UPowerServices.batteryStatus
        readonly property string status: UPowerServices.status

        Row {
            id: batteryRow
            anchors.centerIn: parent
            height: parent.height

            TextStyledH {
                anchors.verticalCenter: parent.verticalCenter
                id: batterySymbol
                rotation: 90
                text: {
                    if (batteryStatus === 4 && batteryLevel === 1) return "󰂄"
                    if (batteryStatus === 1) return "󰂄"
                    if (batteryLevel === 1) return "󰁹"
                    if (batteryLevel >= 0.9) return "󰂂"
                    if (batteryLevel >= 0.8) return "󰂁"
                    if (batteryLevel >= 0.7) return "󰂀"
                    if (batteryLevel >= 0.6) return "󰁿"
                    if (batteryLevel >= 0.5) return "󰁾"
                    if (batteryLevel >= 0.4) return "󰁽"
                    if (batteryLevel >= 0.3) return "󰁼"
                    if (batteryLevel >= 0.2) return "󰁻"
                    if (batteryLevel >= 0.1) return "󰁺"
                    return "󰂎"
                }
            }
        }
    }
}