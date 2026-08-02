import QtQuick
import qs.config
import qs.components

Item {
    id: root
    height: parent.height; width: height
    // onLeftClicked: UIState.isPowerOpen = !UIState.isPowerOpen

    TextStyled {
        anchors.centerIn: parent
        font.pixelSize: parent.height
        text: ""
        color: hover.hovered ? Theme.textAccent : Qt.lighter(Theme.textAccent, Style.hover)
    }

    HoverHandler {
        id: hover
    }
}