import QtQuick
import qs.components
import qs.config

Item {
    id: root
    height: parent.height; width: height

    property string text: ""
    property bool occupied: false
    property bool focused: false
    property bool isHovered: false

    signal clicked()

    TextStyled {
        id: buttonText
        anchors.centerIn: root
        font.pixelSize: root.height
        color: hover.hovered && !occupied ? Qt.lighter(focused ? Theme.inactive : Theme.surfaceRaised, Style.hover)
            : occupied ? Theme.textAccent
            : focused ? Theme.textInactive
            : Theme.textSurface
        text: root.text
    }

    HoverHandler {id: hover}
    TapHandler {onTapped: root.clicked()}
}