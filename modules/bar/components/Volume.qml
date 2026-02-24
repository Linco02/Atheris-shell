import QtQuick
import Quickshell
import Quickshell.Io
import qs.services
import qs.config
import qs.components

Item {
    height: root.height - Appearance.padding.normal; width: volumeText.width + Appearance.padding.normal

    property real volumeLevel: 0

    function volumeLevelCheck(data) {
        const volumeSplit = data.split(":")
        const volume = volumeSplit[1]
        volumeLevel = volume * 100
    }

    Connections {
        target: Tick1s
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

    TextStyledH {
        id: volumeText
        anchors.centerIn: parent
        text: "󰕾"
    }
}