import QtQuick
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.components.animations
import qs.config

RectForeground {
    id: root
    width: buttonIcon.width + Global.padding.normal
    color: isHovered && !occupied ? Qt.lighter(focused ? Colors.inactive : Colors.surfaceRaised, Global.appearance.hover)
        : occupied ? Colors.active
        : focused ? Colors.inactive
        : Colors.surfaceRaised

    Behavior on color { ColorAnim { } }

    property alias iconSize: buttonIcon.implicitSize
    property alias source: buttonIcon.source
    property alias acceptedButtons: buttonReaction.acceptedButtons
    property bool occupied: false
    property bool focused: false
    property bool isHovered: false

    signal leftClicked()
    signal rigthClicked()
    signal midleClicked()

    IconImage {
        id: buttonIcon
        anchors.centerIn: parent
        implicitSize: root.height - Global.padding.mini * 2
    }

    MouseFill {
        id: buttonReaction
        hoverEnabled: true
        onEntered: { isHovered = true }
        onExited: { isHovered = false }
        onClicked: (mouse) => {
            if (mouse.button === Qt.MiddleButton) root.midleClicked()
            else if (mouse.button === Qt.RightButton) root.rigthClicked()
            else root.leftClicked()
        }
    }
}