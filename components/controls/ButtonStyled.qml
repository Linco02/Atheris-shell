import QtQuick
import qs.components
import qs.components.shapes
import qs.components.animations
import qs.config

RectForeground {
    id: root
    width: buttonText.width + Global.padding.large
    color: isHovered && !occupied ? Qt.lighter(focused ? Colors.inactive : Colors.surfaceRaised, Global.appearance.hover)
        : occupied ? Colors.active
        : focused ? Colors.inactive
        : Colors.surfaceRaised

    property alias text: buttonText.text
    property alias acceptedButtons: buttonReaction.acceptedButtons
    property bool occupied: false
    property bool focused: false
    property bool isHovered: false

    signal leftClicked()
    signal rightClicked()
    signal middleClicked()

    TextStyledH {
        id: buttonText
        anchors.centerIn: parent
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
}