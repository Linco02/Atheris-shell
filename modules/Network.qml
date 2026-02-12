import QtQuick
import Quickshell
import Quickshell.Io
import qs.components
import qs.singletons
import qs.settings

Item {
    height: 20; width: networkText.width + Style.padding * 2
    property string currentNetwork: ""

    function networkName(data) {
        const networString = data.split("\n")
        for (const networkList of networString) {
            const parts = networkList.split(":")
            if (parts[1] === "connected") {
                if (parts[0] === "enp4s0") {
                    currentNetwork = ""
                    return
                } else if (parts[0] === "wlp6s0") {
                    currentNetwork = "󰖩"
                    return
                } else {
                    currentNetwork = "󰖪"
                }
            }
        }        
    }

    Connections {
        target: Timer3s
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

    TextStyle2 {
        id: networkText
        anchors.centerIn: parent
        text: currentNetwork
    }
}