pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
    property bool isBluetoothOn: adapter.enabled
    property var adapter: Bluetooth.defaultAdapter
    property var devices: adapter.devices
    property var connectedDevices: {
        if(!devices) return;
        return devices.values.filter(d => d.connected);
    }
    property var avalibleDevices: {
        if(!devices) return;
        return devices.values.filter(d => !d.connected);
    }

    function bluetoothToggle() {
        adapter.enabled = !adapter.enabled
    }

    function bluetoothList() {
        return
    }
}