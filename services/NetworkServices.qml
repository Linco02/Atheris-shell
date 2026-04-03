pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property string currentNetworkSimbol: ""

    function networkName(data) {
        const networString = data.split("\n")
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

    Connections {
        target: Tick3s
        function onTick() {networkNameInfo.running = true}
    }

    Process {
        id: networkNameInfo
        running: true
        command: [ "sh", "-c", "nmcli -t -f DEVICE,STATE,CONNECTION device status" ]
        stdout: StdioCollector {
            onStreamFinished: {
                networkName(this.text)
            }
        }
    }
}