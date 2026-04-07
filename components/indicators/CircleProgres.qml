import QtQuick
import QtQuick.Shapes
import qs.components.animations
import qs.config

Item {
    id: root
    width: height

    property real progres: 0
    property int progresW: 10
    property int angleStart: 90
    property int angleEnd: 360

    ProgressBar { }
    ProgressBar {
        progresColor: Colors.active
        progresBar: progres
    }

    component ProgressBar: Shape {
        anchors.centerIn: root
        height: root.height; width: height
        layer {
            enabled: true
            samples: 4
        }

        property color progresColor: Colors.inactive
        property real progresBar: 1

        ShapePath {
            fillColor: "transparent"
            strokeColor: progresColor
            strokeWidth: progresW
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: root.width / 2; centerY: centerX
                radiusX: root.width / 2 - progresW / 2; radiusY: radiusX
                startAngle: angleStart; sweepAngle: angleEnd * progresBar

                Behavior on sweepAngle { NumberAnim {} }
            }
        }
    }
}