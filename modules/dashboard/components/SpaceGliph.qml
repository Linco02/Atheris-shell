import QtQuick
import Quickshell.Io
import qs.config
import qs.services
import qs.components.shapes
import qs.components

RectForeground {
    id: root
    property int indicator1: 0
    property int indicator2: 0

    property string textInd1: ""
    property string textInd2: ""
    property double percent: 0

    Connections {
        target: Tick3s
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
        spacing: Appearance.spacing.normal
        padding: Appearance.padding.large
        anchors.centerIn: parent
        width: parent.width - Appearance.padding.large

        readonly property real maxTextWidth: Math.max(fillText.implicitWidth, avalibleText.implicitWidth)

        TextStyled {
            id: fillText
            width: parent.maxTextWidth
            anchors.verticalCenter: parent.verticalCenter
            text: textInd1
        }

        RectInactive {
            anchors.verticalCenter: parent.verticalCenter
            height: root.height - Appearance.padding.large * 2
            width: parent.width - parent.maxTextWidth * 2 - Appearance.padding.large * 4
            radius: Appearance.radius.normal

            RectActive {
                anchors.left: parent.left
                height: parent.height; width: parent.width * percent

                radius: parent.radius
            }
        }

        TextStyled {
            id: avalibleText
            width: parent.maxTextWidth
            anchors.verticalCenter: parent.verticalCenter
            text: textInd2
        }
    }
}