import QtQuick
import qs.config
import qs.components

Item {
    height: Theme.barWidth - Theme.stock.small; width: height

    TextStyled {
        id: powerButton
        anchors.centerIn: parent
        fontSize: Theme.barWidth - Theme.stock.small
        text: ""
    }

    HoverHandler {id: hover}
    TapHandler {onTapped: UIState.isPowerOpen = !UIState.isPowerOpen}
}