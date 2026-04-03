import QtQuick
import qs.config
import Quickshell.Widgets
import qs.components.shapes
import qs.components.animations
import qs.components

RectForeground {
    id: root
    width: buttonIcon.width + Global.padding.normal

    property alias implicitSize: buttonIcon.implicitSize
    property alias source: buttonIcon.source
    property alias acceptedButtons: buttonReaction.acceptedButtons
    property bool occupied: false
    property bool focused: false

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
        onEntered: parent.color = Qt.lighter(Colors.surfaceRaised, Global.appearance.hover)
        onExited: parent.color = Colors.surfaceRaised
        onClicked: (mouse) => {
            if (mouse.button === Qt.MiddleButton) root.midleClicked()
            else if (mouse.button === Qt.RightButton) root.rigthClicked()
            else root.leftClicked()
        }
    }

    Behavior on color { ColorAnim { } }
}