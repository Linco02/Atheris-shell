import QtQuick
import Quickshell.Io
import qs.components
import qs.settings
import qs.singletons

RectForeground {
    id: root
    property int indicator1: 0
    property int indicator2: 0

    property string textInd1: ""
    property string textInd2: ""
    property double percent: 0

    Connections {
        target: Timer3s
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

    Row {
        spacing: Style.spacing
        padding: Style.padding2x
        anchors.centerIn: parent
        width: parent.width - Style.padding2x

        readonly property real maxTextWidth: Math.max(fillText.implicitWidth, avalibleText.implicitWidth)

        TextStyle1 {
            id: fillText
            width: parent.maxTextWidth
            anchors.verticalCenter: parent.verticalCenter
            text: textInd1
        }

        RectInactive {
            anchors.verticalCenter: parent.verticalCenter
            height: root.height - Style.padding2x * 2
            width: parent.width - parent.maxTextWidth * 2 - Style.padding2x * 4
            radius: Style.radius

            RectActive {
                anchors.left: parent.left
                height: parent.height; width: parent.width * percent

                radius: parent.radius
            }
        }

        TextStyle1 {
            id: avalibleText
            width: parent.maxTextWidth
            anchors.verticalCenter: parent.verticalCenter
            text: textInd2
        }
    }
}