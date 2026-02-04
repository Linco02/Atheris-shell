import QtQuick
import Quickshell.Io
import qs.elements
import qs.singles

RectForeground {
    id: root
    property int indicator1: 0
    property int indicator2: 0

    property string textInd1: ""
    property string textInd2: ""
    property double percent: 0

    height: 60; width: parent.width - 20

    Connections {
        target: SingleTimer2
        function onTick() { checkInfo.running = true }
    }

    Process {
        id: checkInfo
        running: true
        command: [
            "sh", "-c",
            "df -h / | awk 'NR == 2 {print $2, $4}' | tr -d 'G'"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                var info = this.text.trim().split(" ")
                indicator1 = parseInt(info[0])
                indicator2 = parseInt(info[1])
                percent = (indicator1 - indicator2) / indicator1
                textInd1 = (indicator1 - indicator2) + "Гб"
                textInd2 = indicator2 + "Гб"
            }
        }
    }

    RectBackground {
        id: box
        anchors.centerIn: parent
        height: parent.height - 20; width: parent.width - 20
        radius: Style.radius - 5
    }

    Rectangle {
        anchors {
            left: box.left
            verticalCenter: parent.verticalCenter
        }
        height: parent.height - 20; width: (parent.width - 20) * percent

        color: Style.activeColor
        radius: Style.radius - 5
    }

    TextStyle1 {
        anchors {
            verticalCenter: parent.verticalCenter
        }
        x: 20
        text: textInd1
    }

    TextStyle1 {
        anchors {
            verticalCenter: parent.verticalCenter
        }
        x: root.width - width - 20
        text: textInd2
    }
}