import QtQuick
import qs.components

RectForeground {
    height: 20; width: 100
    Text {
        anchors.centerIn: parent
        // text: Qt.locale().name.split("_")[1]
        // text: InputMethod.currentLayout
    }
}