pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton {
    readonly property real batteryLevel: UPower.displayDevice.percentage
    readonly property real batteryStatus: UPower.displayDevice.state // 1 - заряджається; 2 - розряджається; 4 - повністю заряджена
    property string status: "normal"

    onBatteryLevelChanged: { statusChange() }

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

    Component.onCompleted: { statusChange() }
}