pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.config

Singleton {
    property string currentNetworkSimbol: ""
    property var currentWifi: {
        const list = wifiList.filter(w => w.ssid !== undefined && w.active === "так")
        return list.length > 0 ? list[0] : { ssid: "", signal: 0, icon: "󰤯" }
    }
    property var wifiList: []
    property string __wifiConnect: ""
    property bool isRetry: false

    function getWifiList() {
        wifiParce.running = true
    }

    function connectWifi(ssid, password) {
        __wifiConnect = ssid
        if (password) {
            wifiConnect.command = ["nmcli", "dev", "wifi", "connect", ssid, "password", password]
        } else {
            wifiConnect.command = ["nmcli", "dev", "wifi", "connect", ssid]
        }
        wifiConnect.running = true
    }

    Process {
        id: wifiConnect
        onExited: (exitCode, status) => {
            if (exitCode === 4) {
                // const isRetry = __wifiConnect !== ""
                SAuthenficator.requestPassword("wifi" ,__wifiConnect, isRetry)
                isRetry = true
            } else if (exitCode === 0){
                SNotification.nitifiSend("Wifi", "Під'єднано до мережі", __wifiConnect, "network-wireless", "normal", 0, 0)
                __wifiConnect = ""
            } else {
                console.log("SNetwork", exitCode)
            }
            getWifiList()
        }
    }

    Process {
        id: wifiParce
        command: ["sh", "-c", "nmcli -t -f SSID,SIGNAL,ACTIVE device wifi list"]
        stdout: StdioCollector {
            onStreamFinished: {
                const list = this.text.split("\n")
                const parce = list
                    .filter(l => l.trim() !== "")
                    .filter(l => l.split(":")[0] !== "" && l.split(":")[1] !== "" && l.split(":")[2] !== "")
                    .map(l => {
                        const part = l.split(":")
                        return {
                            ssid: part[0],
                            signal: part[1],
                            active: part[2], 
                            icon: part[1] > 80 ? "󰤨"
                                : part[1] > 60 ? "󰤥"
                                : part[1] > 40 ? "󰤢"
                                : part[1] > 20 ? "󰤟"
                                : "󰤯"
                        }
                    })
                wifiList = parce
            }
        }
    }

    Process {
        id: networkNameInfo
        command: [ "sh", "-c", "nmcli -t -f DEVICE,STATE,CONNECTION device status" ]
        stdout: StdioCollector {
            onStreamFinished: {
                const networString = this.text.split("\n")
                for (const networkList of networString) {
                    const parts = networkList.split(":")
                    if (parts[1] === "connected") {
                        if (parts[0][0] === "e") {
                            currentNetworkSimbol = ""
                            return
                        } else if (parts[0][0] === "w") {
                            currentNetworkSimbol = "󰖩"
                            return
                        } else {
                            currentNetworkSimbol = "󰖪"
                        }
                    }
                }
            }
        }
    }

    Connections {
        target: STick
        function onTick3s() {
            networkNameInfo.running = true
            if (UIState.isControlCenterOpen)
                wifiParce.running = true
        }
    }

    Component.onCompleted: {
        networkNameInfo.running = true
        wifiParce.running = true
    }
}