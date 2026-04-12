import QtQuick
import qs.components
import qs.components.shapes
import qs.services

RectForeground {
    width: parent.width

    TextStyled {
        anchors.centerIn: parent
        text: PerfomanceServices.powerProfile
    }
}