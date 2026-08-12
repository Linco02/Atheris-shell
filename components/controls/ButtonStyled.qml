import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.animations
import qs.config

RectForeground {
    id: root
    width: buttonText.width + Style.padding.large
    color: hovered && !isActive ? Qt.lighter(Theme.inactive, Style.hover)
        : isActive ? Theme.active
        : Theme.inactive

    property alias text: buttonText.text
    property bool isActive: false
    property bool fullH: true
    property bool hoзолvered: hover.hovered

    signal clicked()

    TextStyled {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: fullH === true ? parent.height - Style.padding.small : Style.fontSize
        color: isActive ? Theme.textAccent : Theme.textSurface
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: clicked() }
}