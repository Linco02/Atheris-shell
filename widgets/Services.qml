import QtQuick
import qs.modules
import qs.components
import qs.settings

RectForeground {
    height: panelHeight - Style.padding2x; width: servicesContainer.width + Style.padding * 2
    Row {
        anchors.centerIn: parent
        id: servicesContainer
        Volume {}
        Network {}
        Language {}
    }
}