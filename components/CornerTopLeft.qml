import QtQuick
import QtQuick.Shapes
import qs.settings

PanelWindow {
    id: leftCorner
    anchors {
        top: parent.top
        left: parent.top
    }
    implicitHeight: radius; implicitWidth: radius

    Shape {
        height: parent.height; width: parent.width
        anchors.fill: parent
        ShapePath {
            strokeWidth: 0
            fillColor: Style.backGround
            startY: radius; startX: 0
            PathArc {
                y: 0; x: radius
                radiusX: radius; radiusY: radius
                useLargeArc: false
            }
            PathLine { y: 0; x: 0; }
            PathLine { y: radius; x: 0 }
        }
    }
}