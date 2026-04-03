import QtQuick
import Quickshell
import Quickshell.Io
import qs.services
import qs.config
import qs.components

Item {
    height: parent.height; width: volumeText.width

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

    Process {
        id: pavucontrol
        command: [ "pavucontrol" ]
    }

    MouseArea {
        anchors.fill: parent
        onClicked: pavucontrol.running = true
    }
}