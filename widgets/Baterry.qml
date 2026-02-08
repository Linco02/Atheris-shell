import QtQuick
import Quickshell.Services.UPower
import qs.components

Item {
    height: 20; width: 100

    RectForeground {
        anchors.fill: parent

        Text {
            text: UPower.displayDevice.percentage * 100 + "%"
        }
    }
}