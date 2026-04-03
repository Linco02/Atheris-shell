import QtQuick
import qs.components
import qs.components.animations
import qs.config

Item {
    id: root
    width: buttonText.width + Global.padding.large

    property alias text: buttonText.text
    property bool occupied: false
    property bool focused: false
    property bool isHovered: false

    signal leftClicked()
    signal rightClicked()
    signal middleClicked()

    TextStyled {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: parent.height
        color: isHovered && !occupied ? Qt.lighter(focused ? Colors.inactive : Colors.surfaceRaised, Global.appearance.hover)
            : occupied ? Colors.textAccent
            : focused ? Colors.textInactive
            : Colors.textSurface

        Behavior on color { ColorAnim { } }
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