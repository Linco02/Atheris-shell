pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton {
    readonly property bool isExist: UPower.displayDevice.isPresent
    readonly property real batteryLevel: UPower.displayDevice.percentage
    property int batteryLevelRound: batteryLevel * 100
    readonly property real batteryStatus: UPower.displayDevice.state // 1 - заряджається; 2 - розряджається; 4 - повністю заряджена
    property string status: batteryLevel >= 0.2 ? "normal"
        : batteryLevel < 0.1 ? "critical"
        : "warning"
    property string batteryIcon: {
        if (batteryStatus === 4 && batteryLevel === 1) return "󰂄"
        if (batteryStatus === 1) return "󰂄"
        if (batteryLevel === 1) return "󰁹"
        var icons = ["󰂎","󰁺","󰁻","󰁼","󰁽","󰁾","󰁿","󰂀","󰂁","󰂂","󰁹"]
        return icons[Math.min(Math.floor(batteryLevel * 10), 10)]
    }

    onBatteryLevelChanged: { statusChange() }

    function statusChange() {
        if (batteryLevel >= 0.2) {
            if (status != "normal") {
                status = "normal"
            }
        } else if (batteryLevel < 0.1) {
            if (status != "critical") {
                status = "critical"
                // Notifications.send("Battery", "Critical level!", "critical")
            }
        } else if (batteryLevel < 0.2) {
            if (status != "warning") {
                status = "warning"
                // Notifications.send("Battery", "Low battery", "normal")
            }
        }
    }

    Component.onCompleted: { statusChange() }

    property var power: PowerProfiles
    property var degradation: power.degradationReason
    property string powerProfile: PowerProfile.toString(power.profile)
    property string degradationReason: PerformanceDegradationReason.toString(degradation)

    onDegradationChanged: {
        if (degradation === 0) return
        console.log("Power", "Проблеми з продуктивністю", degradationReason)
        SNotification.nitifiSend("Power", "Проблеми з продуктивністю", degradationReason, "system-error-symbolic", critical, 0, 0)
    }

    function changePowerProfile(profile) {
        // const parse = profile === ""
        
    }
}