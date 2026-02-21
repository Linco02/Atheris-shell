import QtQuick
import Quickshell
import QtQuick.Shapes
import Quickshell.Io
import qs.components
import qs.settings
import qs.singletons

Item {
    id: root
    height: 240; width: 220

    property var listData: info3 === "GPU" ? PerfomanceInit.gpu : info3 === "CPU" ? PerfomanceInit.cpu : PerfomanceInit.mem
    property string textInd1: listData.textInd1
    property string textInd2: listData.textInd2
    property double percent: listData.percent

    Behavior on percent {
        NumberAnimation {
            duration: Style.spedAnim
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
            layer {
                enabled: true
                samples: 4
            }

            ShapePath {
                strokeColor: Style.inactiveColor
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
            layer {
                enabled: true
                samples: 4
            }

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