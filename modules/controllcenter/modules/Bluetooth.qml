import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.config
import qs.services

ButtonTripled {
    width: parent.width
    icon: "󰂯"
    textTop: "Bluetooth"
    textBottom: SBluetooth.connectedDevices[0].name || ""
    isActive: SBluetooth.isBluetoothOn
    onClicked: UIState.controlCenterModul = "bluetooth"
}