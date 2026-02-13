import QtQuick
import Quickshell
import Quickshell.Io
import qs.components
import qs.singletons
import qs.settings

Item {
    height: panelHeight - Style.padding2x; width: volumeText.width + Style.padding * 2

    property real volumeLevel: 0

    function volumeLevelCheck(data) {
        const volumeSplit = data.split(":")
        const volume = volumeSplit[1]
        volumeLevel = volume * 100
    }

    Connections {
        target: Timer1s
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

    TextStyle2 {
        id: volumeText
        anchors.centerIn: parent
        text: "󰕾"
    }
}