import QtQuick
import Quickshell
import QtQuick.Shapes
import Quickshell.Io
import qs.config
import qs.services
import qs.components.shapes
import qs.components.animations
import qs.components

Item {
    id: root
    height: 240; width: 220

    property var listData: info3 === "GPU" ? PerfomanceInit.gpu : info3 === "CPU" ? PerfomanceInit.cpu : PerfomanceInit.mem
    property string textInd1: listData.textInd1
    property string textInd2: listData.textInd2
    property double percent: listData.percent

    Behavior on percent { NumberAnim { }}

    RectForeground {
        id: box
        anchors.fill: parent

        TextStyled {
            id: name
            anchors.horizontalCenter: parent.horizontalCenter
            y: 5
            text: root.info3
        }

    
        TextStyled {
            id: insideGliph
            anchors.horizontalCenter: parent.horizontalCenter
            y: name.height + glifBackground.height / 2 - 10
            text: root.textInd1
        }

        TextStyled {
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
                strokeColor: Appearance.inactive
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
                strokeColor: Appearance.active
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