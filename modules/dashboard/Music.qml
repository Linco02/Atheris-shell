import QtQuick
import qs.config
import qs.components.shapes
import qs.components

Item {
    implicitHeight: musicPage.height
    implicitWidth: musicPage.width

    RectForeground {
        id: musicPage
        anchors.centerIn: parent
        implicitHeight: 500
        implicitWidth: 700
    }
}