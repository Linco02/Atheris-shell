pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.config

import Quickshell.Networking

Singleton {
    property bool isWifiOn: Networking.wifiEnabled
    property var networking: Networking
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

    function getDeviceStatus(device) {
        if (!device) return "";
        return ConnectionState.toString(device.state);
    }

    function toggleWifi() {
        Networking.wifiEnabled = !isWifiOn;
        checkConnectivity();
    }  

    function connectNetwork(network) {
        errorDetector.target = network;
        network.connect();
        checkConnectivity();
    }

    function connectNetworkWithPsk(network, password) {
        network.connectWithPsk(password)
        checkConnectivity();
    }

    function disconnectNetwork(network) {
        network.disconnect();
        checkConnectivity();
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

// Singleton {
//     property bool isWifiOn: true
//     property string currentNetworkSimbol: ""
//     property var currentWifi: {
//         const list = wifiList.filter(w => w.ssid !== undefined && w.active === "так")
//         return list.length > 0 ? list[0] : { ssid: "", signal: 0, icon: "󰤯" }
//     }
//     property var wifiList: []
//     property string __wifiConnect: ""
//     property bool isRetry: false

//     function toggleWifi() {
//         wifiRadio.command = ["nmcli", "radio", "wifi", isWifiOn ? "off" : "on"]
//         wifiRadio.running = true

//         isWifiOn = !isWifiOn
//     }

//     function getWifiList() {
//         wifiParce.running = true
//     }

//     function connectWifi(ssid, password) {
//         __wifiConnect = ssid
        
//         wifiConnect.command = password
//             ? wifiConnect.command = ["nmcli", "dev", "wifi", "connect", ssid, "password", password]
//             : wifiConnect.command = ["nmcli", "dev", "wifi", "connect", ssid]
//         wifiConnect.running = true
//     }

//     Process {
//         id: wifiConnect
//         onExited: (exitCode, status) => {
//             if (exitCode === 4) {
//                 // const isRetry = __wifiConnect !== ""
//                 SAuthenficator.requestPassword("wifi" ,__wifiConnect, isRetry)
//                 isRetry = true
//             } else if (exitCode === 0){
//                 SNotification.nitifiSend("Wifi", "Під'єднано до мережі", __wifiConnect, "network-wireless", "normal", 0, 0)
//                 __wifiConnect = ""
//             } else {
//                 console.log("SNetwork", exitCode)
//             }
//             getWifiList()
//         }
//     }

//     Process {
//         id: wifiParce
//         command: ["sh", "-c", "nmcli -t -f SSID,SIGNAL,ACTIVE device wifi list"]
//         stdout: StdioCollector {
//             onStreamFinished: {
//                 const list = this.text.split("\n")
//                 const parce = list
//                     .filter(l => l.trim() !== "")
//                     .filter(l => l.split(":")[0] !== "" && l.split(":")[1] !== "" && l.split(":")[2] !== "")
//                     .map(l => {
//                         const part = l.split(":")
//                         return {
//                             ssid: part[0],
//                             signal: part[1],
//                             active: part[2], 
//                             icon: part[1] > 80 ? "󰤨"
//                                 : part[1] > 60 ? "󰤥"
//                                 : part[1] > 40 ? "󰤢"
//                                 : part[1] > 20 ? "󰤟"
//                                 : "󰤯"
//                         }
//                     })
//                 wifiList = parce
//             }
//         }
//     }

//     Process {
//         id: networkNameInfo
//         command: [ "sh", "-c", "nmcli -t -f DEVICE,STATE,CONNECTION device status" ]
//         stdout: StdioCollector {
//             onStreamFinished: {
//                 const networString = this.text.split("\n")
//                 for (const networkList of networString) {
//                     const parts = networkList.split(":")
//                     if (parts[1] === "connected") {
//                         if (parts[0][0] === "e") {
//                             currentNetworkSimbol = ""
//                             return
//                         } else if (parts[0][0] === "w") {
//                             currentNetworkSimbol = "󰖩"
//                             return
//                         } else {
//                             currentNetworkSimbol = "󰖪"
//                         }
//                     }
//                 }
//             }
//         }
//     }

//     Process {
//         id: wifiRadio
//     }

//     Connections {
//         target: STick
//         function onTick3s() {
//             networkNameInfo.running = true
//             if (UIState.isControlCenterOpen)
//                 wifiParce.running = true
//         }
//     }

//     Component.onCompleted: {
//         networkNameInfo.running = true
//         wifiParce.running = true
//     }
// }