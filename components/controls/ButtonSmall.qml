import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.animations
import qs.config

Button {
    id: root

    background: RectInactive {
        height: parent.height; width: parent.width

        color: parent.pressed ? Colors.active
            : parent.hovered ? Colors.surfaceRaised
            : Colors.surface

        Behavior on color { ColorAnim { } }
    }

    contentItem: Item {
        anchors.fill: parent

        TextStyled {
            anchors.centerIn: parent
            text: root.text
            font.pixelSize: root.height / 2
        }
    }
}