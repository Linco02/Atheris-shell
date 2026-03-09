import QtQuick
import qs.config
import qs.components.shapes

RectForeground {
    height: root.height - Appearance.padding.normal
    width: servicesContainer.width + Appearance.padding.normal

    Row {
        anchors.centerIn: parent
        id: servicesContainer
        Volume {}
        Network {}
        Language {}
    }
}