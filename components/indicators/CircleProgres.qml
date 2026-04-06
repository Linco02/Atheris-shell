import QtQuick
import QtQuick.Shapes
import qs.components.animations
import qs.config

Item {
    id: root
    width: height

    property real progres: 0
    property int progresW: 10

    ProgressBar { progresWidth: progresW }
    ProgressBar {
        progresColor: Colors.active
        progresBar: progres
        progresWidth: progresW
    }

    component ProgressBar: Shape {
        anchors.centerIn: root
        height: root.height; width: height
        layer {
            enabled: true
            samples: 4
        }

        property color progresColor: Colors.inactive
        property int progresWidth: 10
        property real progresBar: 1

        ShapePath {
            fillColor: "transparent"
            strokeColor: progresColor
            strokeWidth: progresWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: root.width / 2; centerY: centerX
                radiusX: root.width / 2 - progresWidth / 2; radiusY: radiusX
                startAngle: 90; sweepAngle: 360 * progresBar

                Behavior on sweepAngle { NumberAnim {} }
            }
        }
    }
}