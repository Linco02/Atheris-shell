import QtQuick
import Quickshell
import Quickshell.Io
import qs.components
import qs.singletons

RectForeground {
    height: 20; width: 80

    property real volumeLevel: 0

    function volumeLevelCheck(data) {
        const volumeSplit = data.split(":")
        const volume = volumeSplit[1]
        volumeLevel = volume * 100
    }

    Connections {
        target: SingleTimer1
        function onTick() {volumeLevelInfo.running = true}
    }

    Process {
        id: volumeLevelInfo
        running: true
        command: [ "sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@" ]
        stdout: StdioCollector {
            onStreamFinished: {
                volumeLevelCheck(this.text)
            }
        }
    }

    Text {
        anchors.centerIn: parent
        text: "󰕾 " + volumeLevel + "%"
    }
}