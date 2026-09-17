import QtQuick
import qs.config
import qs.components

Item {
    id: root
    width: height

    TextStyled {
        anchors.centerIn: parent
        font.pixelSize: parent.height
        text: ""
        // color: hover.hovered ? Theme.colors.textAccent : Qt.lighter(Theme.colors.textAccent, Theme.hover)
    }

    HoverHandler {id: hover}
    TapHandler {onTapped: UIState.isPowerOpen = !UIState.isPowerOpen}
}