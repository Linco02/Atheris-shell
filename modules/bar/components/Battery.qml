import QtQuick
import Quickshell.Services.UPower
import qs.config
import qs.services
import qs.components.shapes
import qs.components

Item {
    height: parent.height; width: batteryRow.width
    visible: UPower.displayDevice.isPresent

    readonly property real batteryLevel: UPower.displayDevice.percentage
    readonly property real batteryStatus: UPower.displayDevice.state
    // 1 - заряджається
    // 2 - розряджається
    // 4 - повністю заряджена
    property string status: "normal"

    onBatteryLevelChanged: {
        statusChange()
    }

    function statusChange() {
        if (batteryLevel >= 0.2) {
            if (status != "normal") {
                status = "normal"
                batterySymbol.color = Colors.textSurface
            }
        } else if (batteryLevel < 0.1) {
            if (status != "critical") {
                status = "critical"
                batterySymbol.color = Colors.textAccent
                Notifications.send("Battery", "Critical level!", "critical")
            }
        } else if (batteryLevel < 0.2) {
            if (status != "warning") {
                status = "warning"
                batterySymbol.color = Colors.textAccent
                Notifications.send("Battery", "Low battery", "normal")
            }
        }
    }

    Row {
        id: batteryRow
        anchors.centerIn: parent
        height: parent.height

        // TextStyledFH {
        //     anchors.verticalCenter: parent.verticalCenter
        //     id: batteryPercent
        //     text: (UPower.displayDevice.percentage * 100) + "% "
        // }

        TextStyledFH {
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



    Component.onCompleted: {
        if (visible)
            statusChange()
    }
}