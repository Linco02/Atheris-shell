pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
    property bool isBluetoothOn: adapter?.enabled || false
    property var adapter: Bluetooth?.defaultAdapter
    property var devices: adapter?.devices
    property var pairedDevices: {
        if(!devices) return [];
        return devices.values.filter(d => d.paired);
    }
    property var connectedDevices: {
        if(!pairedDevices) return [];
        return pairedDevices.filter(d => d.connected);
    }
    property var avalibleDevices: {
        if(!devices) return [];
        return devices.values.filter(d => !d.paired);
    }

    function bluetoothToggle() {adapter.enabled = !adapter.enabled}
    function discoverableToogle() {adapter.discoverable = !adapter.discoverable} // Пошук цього пристрою
    function discoveringToggle() {adapter.discovering = !adapter.discovering} // Пошук інших пристроїв
    function pairableTggle() {adapter.pairable = !adapter.pairable}
}