import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.animations
import qs.config

RectForeground {
    id: root
    width: buttonText.width + Theme.padding.large
    color: hovered && !isActive ? Qt.lighter(Theme.colors.inactive, Theme.hover)
        : isActive ? Theme.colors.active
        : Theme.colors.inactive

    property alias text: buttonText.text
    property int fontSize: fillH === true ? root.height - Theme.padding.small : Theme.fontSize
    property bool isActive: false
    property bool fillH: true
    property bool hovered: hover.hovered

    signal clicked()

    TextStyled {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: root.fontSize
        color: isActive ? Theme.colors.textAccent : Theme.colors.textSurface
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: clicked() }
}