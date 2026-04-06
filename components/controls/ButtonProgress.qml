import QtQuick
import QtQuick.Shapes
import qs.components
import qs.config

Item {
    id: root
    height: parent.height; width: height

    property alias text: buttonText.text
    property bool occupied: false
    property bool focused: false
    property bool isHovered: false

    signal leftClicked()
    signal rightClicked()
    signal middleClicked()

    ProgressGliph {
        colorBack: Colors.inactive
    }

    ProgressGliph {
        colorBack: Colors.active
    }

    TextStyled {
        id: buttonText
        anchors.centerIn: root
        font.pixelSize: root.height
        color: isHovered && !occupied ? Qt.lighter(focused ? Colors.inactive : Colors.surfaceRaised, Global.appearance.hover)
            : occupied ? Colors.textAccent
            : focused ? Colors.textInactive
            : Colors.textSurface
    }

    MouseFill {
        id: buttonReaction
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        onEntered: { isHovered = true }
        onExited: { isHovered = false }
        onClicked: (mouse) => {
            if (mouse.button === Qt.MiddleButton) root.middleClicked()
            else if (mouse.button === Qt.RightButton) root.rightClicked()
            else root.leftClicked()
        }
    }

    component ProgressGliph: Shape {
        id: shape
        anchors.centerIn: parent
        height: parent.height; width: height
        layer {
            enabled: true
            samples: 4
        }

        property alias colorBack: path.fillColor

        ShapePath {
            id: path
            fillColor: "transparent"
            strokeWidth: 0

            PathAngleArc {
                centerX: shape.height / 2; centerY: centerX
                radiusX: shape.height / 2; radiusY: radiusX
                startAngle: 0
                sweepAngle: 360
            }
        }
    }
}