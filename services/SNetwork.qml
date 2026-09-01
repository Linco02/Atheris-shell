pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Networking
import qs.config


Singleton {
    property bool isWifiOn: Networking.wifiEnabled || false
    // property bool scannerState: WifiDevice.scannerEnabled
    property var devices: Networking.devices.values
    property var currentDevice: {
        if (!devices) return [];
        return devices.find(d => d.connected === true) ?? null;
    }
    property var networks: currentDevice?.networks.values
    property var currentNetwork: {
        if (!networks) return [];
        return networks.find(n => n.connected === true) ?? null;
    }
    property var anotherNetworks: {
        if (!networks) return [];
        return networks.filter(n => n.connected !== true);
    }

    function getIcon(network) {
        // if (!network) return Quickshell.iconPath("network-wireless-offline-symbolic")
        
        const strength = network.signalStrength || 0
        let mapedIcon = "network-wireless-signal-none-symbolic"

        if (strength > 0.8) mapedIcon = "network-wireless-signal-excellent-symbolic"
        else if (strength > 0.6) mapedIcon = "network-wireless-signal-good-symbolic"
        else if (strength > 0.4) mapedIcon = "network-wireless-signal-ok-symbolic"
        else if (strength > 0.2) mapedIcon = "network-wireless-signal-weak-symbolic"

        return Quickshell.iconPath(mapedIcon);
    }

    function getNerdIcon(network) {
        const strength = network.signalStrength || 0
        let mapedIcon = "󰤯"

        if (strength > 0.8) mapedIcon = "󰤨"
        else if (strength > 0.6) mapedIcon = "󰤥"
        else if (strength > 0.4) mapedIcon = "󰤢"
        else if (strength > 0.2) mapedIcon = "󰤟"

        return mapedIcon;
    }

    function getDeviceStatus(device) {
        if (!device) return "";
        return ConnectionState.toString(device.state);
    }

    function toggleWifi() {
        Networking.wifiEnabled = !isWifiOn;
    }

    // function toggleScan() {
    //     WifiDevice.scannerEnabled = !scannerState
    // }


    function connectNetwork(network) {
        errorDetector.target = network;

        if (network.known) network.connect();
        else SAuthenficator.requestPassword("wifi", network, false);
    }

    function connectNetworkWithPsk(network, password) {
        network.connectWithPsk(password)
    }

    function disconnectNetwork(network) {
        network.device.disconnect();
    }

    function checkConnectivity() {Networking.checkConnectivity()}

    Connections {
        id: errorDetector
        target: null
        function onConnectionFailed(reason) {
            const network = target;

            if (reason !== 1) return;

            SAuthenficator.requestPassword("wifi", network, false);
        }
    }
}