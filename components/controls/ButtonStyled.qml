import QtQuick
import qs.config
import qs.components.shapes
import qs.components.animations
import qs.components

RectForeground {
    id: root
    width: buttonText.width + Global.padding.large

    property alias text: buttonText.text
    signal clicked()

    TextStyledH {
        id: buttonText
    }

    MouseFill {
        id: buttonReaction
        hoverEnabled: true
        onEntered: parent.color = Qt.lighter(Colors.surfaceRaised, Global.appearance.hover)
        onExited: parent.color = Colors.surfaceRaised
        onClicked: root.clicked()
    }

    Behavior on color { ColorAnim { } }
}