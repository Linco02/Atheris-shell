import QtQuick
import qs.components
import qs.settings

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