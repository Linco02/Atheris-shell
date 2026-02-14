import QtQuick
import Quickshell
import QtQuick.Shapes
import Quickshell.Io
import qs.components
import qs.settings
import qs.singletons

Item {
    id: root
    property int total1: 0
    property int idle1: 0
    
    property int indicator1: 0
    property int indicator2: 0

    property string textInd1: ""
    property string textInd2: ""
    property double percent: 0

    height: 240; width: 220
    
    Connections {
        target: Timer3s
        function onTick() { checkInfo.running = true }
    }

    Process {
        id: checkInfo
        running: true

        command: {
            if (root.info3 === "GPU") {
                return [
                    "sh", "-c",
                    "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits"
                ]
            } else if (root.info3 === "CPU") {
                return [
                    "sh", "-c",
                    "awk 'NR == 1 { idle = $5 + $6; total = 0; for (i=2; i<=9; i++) total += $i; print idle, total}' /proc/stat && cat /sys/class/hwmon/hwmon3/temp1_input"
                ]
                } else {
                return [
                    "sh", "-c",
                    "awk 'NR<=3 && NR!=2 {print $2}' /proc/meminfo"
                ]
            }
        }

        stdout: StdioCollector {
            onStreamFinished: {
                // GPU Indicator
                if (root.info3 === "GPU") {
                    var info = this.text.trim().split(",")
                    indicator1 = parseInt(info[0])
                    indicator2 = parseInt(info[1])

                    textInd1 = indicator1 + "%"
                    textInd2 = indicator2 + "°C"
                    percent = indicator1 / 100
                // CPU Indicator
                } else if (root.info3 === "CPU") {
                    var info = this.text.trim().split(/\s+/)
                    const idle2 = parseInt(info[0])
                    const total2 = parseInt(info[1])
                    indicator2 = parseInt(info[2]) / 1000

                    percent = (1 - (idle2 - idle1) / (total2 - total1)).toFixed(2)
                    textInd1 = (percent * 100).toFixed(0) + "%"
                    textInd2 = indicator2 + "°C"
                    total1 = total2
                    idle1 = idle2
                // MEM Indicator
                } else {
                    var info = this.text.split("\n")
                    indicator1 = parseInt(info[0]) / 1024
                    indicator2 = parseInt(info[1]) / 1024

                    textInd1 = ((indicator1 - indicator2) / 1000).toFixed(2) + "Гб"
                    textInd2 = ((indicator2) / 1000).toFixed(2) + "Гб"
                    percent = (1 - (indicator2 * 100 / indicator1) / 100).toFixed(2)
                }
            }
        }
    }

    Behavior on percent {
        NumberAnimation {
            duration: 500
            easing.type: Easing.InOutQuad
        }
    }

    RectForeground {
        id: box
        anchors.fill: parent

        TextStyle1 {
            id: name
            anchors.horizontalCenter: parent.horizontalCenter
            y: 5
            text: root.info3
        }

    
        TextStyle1 {
            id: insideGliph
            anchors.horizontalCenter: parent.horizontalCenter
            y: name.height + glifBackground.height / 2 - 10
            text: root.textInd1
        }

        TextStyle1 {
            anchors.horizontalCenter: parent.horizontalCenter
            y: name.height + glifBackground.height + insideGliph.height - 60
            text: root.textInd2
        }

        Shape {
            id: glifBackground
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.width - 20; width: parent.width - 20
            y: name.height + 10

            ShapePath {
                strokeColor: Style.backGround
                strokeWidth: 20
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap

                PathAngleArc {
                    centerX: 100; centerY: 100
                    radiusX: 90; radiusY: 90
                    startAngle: -225
                    sweepAngle: 270
                }
            }
        }

        Shape {
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.width - 20; width: parent.width - 20
            y: name.height + 10

            ShapePath {
                strokeColor: Style.activeColor
                strokeWidth: 20
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap

                PathAngleArc {
                    centerX: 100; centerY: 100
                    radiusX: 90; radiusY: 90
                    startAngle: -225
                    sweepAngle: 270 * percent
                }
            }
        }  
    }
}