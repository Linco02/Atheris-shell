import QtQuick
import Quickshell.Services.UPower
import qs.components

Item {
    height: panelHeight - Style.padding2x; width: 100

    RectForeground {
        anchors.fill: parent

        Text {
            text: UPower.displayDevice.percentage * 100 + "%"
        }
    }
}