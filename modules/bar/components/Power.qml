import QtQuick
import qs.config
import qs.components

Item {
    id: root
    height: Theme.barWidth - Theme.stock.small; width: height

    TextStyled {
        anchors.centerIn: parent
        fontSize: root.height
        text: ""
    }

    TapHandler {onTapped: UIState.power.isOpen = !UIState.power.isOpen}
}