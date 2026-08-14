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
    property var availableDevices: {
        if(!devices) return [];
        return devices.values.filter(d => !d.paired);
    }

    function toggleBluetooth() {adapter.enabled = !adapter.enabled}
    function toggleDiscoverable() {adapter.discoverable = !adapter.discoverable} // Пошук цього пристрою
    function toggleDiscovering() {adapter.discovering = !adapter.discovering} // Пошук інших пристроїв
    function togglePairable() {adapter.pairable = !adapter.pairable}
    function getDeviceStatus(dev) {
        if (!dev) return "";
        return BluetoothDeviceState.toString(dev.state);
    }
}