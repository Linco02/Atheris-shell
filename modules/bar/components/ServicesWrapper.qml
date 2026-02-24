import QtQuick
import qs.components.shapes
import qs.config

RectForeground {
    height: root.height - Appearance.padding.normal; width: servicesContainer.width + Appearance.padding.normal
    Row {
        anchors.centerIn: parent
        id: servicesContainer
        Volume {}
        Network {}
        Language {}
    }
}