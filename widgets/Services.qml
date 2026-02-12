import QtQuick
import qs.modules
import qs.components
import qs.settings

RectBackground {
    height: 20; width: servicesContainer.width + Style.padding * 2
    Row {
        anchors.centerIn: parent
        id: servicesContainer
        Volume {}
        Network {}
        Language {}
    }
}