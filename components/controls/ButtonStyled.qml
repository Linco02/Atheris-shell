import QtQuick
import qs.components
import qs.components.shapes
import qs.components.animations
import qs.config

RectForeground {
    id: root
    width: buttonText.width + Global.padding.large
    color: hover.hovered && !isActive ? Qt.lighter(Colors.inactive, Global.appearance.hover)
        : isActive ? Colors.active
        : Colors.inactive

    property alias text: buttonText.text
    property bool isActive: false
    property bool fullH: true

    signal clicked()

    TextStyled {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: fullH === true ? parent.height - Global.padding.small : Global.appearance.fontSize
        color: isActive ? Colors.textAccent : Colors.textSurface
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: clicked() }
}