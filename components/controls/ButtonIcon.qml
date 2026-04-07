import QtQuick
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.config
import qs.services

RectForeground {
    id: root
    height: parent.height; width: height
    color: isHovered && !occupied ? Qt.lighter(focused ? Colors.inactive : Colors.surfaceRaised, Global.appearance.hover)
        : occupied ? Colors.active
        : focused ? Colors.inactive
        : Colors.surfaceRaised

    property alias iconSize: buttonIcon.implicitSize
    property string source: ""
    property bool occupied: false
    property bool focused: false
    property bool isHovered: false

    signal leftClicked()
    signal rigthClicked()
    signal midleClicked()

    IconImage {
        id: buttonIcon
        anchors.centerIn: parent
        source: AppIcons.getIcon(root.source)
        implicitSize: root.height - Global.padding.mini + 2
    }

    MouseFill {
        id: buttonReaction
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        onEntered: { isHovered = true }
        onExited: { isHovered = false }
        onClicked: (mouse) => {
            if (mouse.button === Qt.MiddleButton) root.midleClicked()
            else if (mouse.button === Qt.RightButton) root.rigthClicked()
            else root.leftClicked()
        }
    }
}