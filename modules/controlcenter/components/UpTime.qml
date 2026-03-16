import QtQuick
import Quickshell.Io
import qs.components
import qs.services

Item {
    height: parent.height; width: childrenRect.width

    property string uptime: "0h 0m"

    Connections {
        target: Tick30s
        function onTick() {
            uptimeProcess.running = true
        }
    }

    Process {
        id: uptimeProcess
        command: ["cat", "/proc/uptime"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const seconds = Math.floor(parseFloat(data.split(" ")[0]))
                const h = Math.floor((seconds % 86400) / 3600)
                const m = Math.floor((seconds % 3600) / 60)
                uptime = `up ${h}h ${m}m`
            }
        }
    }

    TextStyledH {
        anchors.left: parent.left
        text: uptime
    }
}