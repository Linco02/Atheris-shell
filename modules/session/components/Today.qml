import QtQuick
import qs.components
import qs.config
import qs.services

Column {
    anchors.horizontalCenter: parent.horizontalCenter

    OwnText {
        text: TimeServices.time
        font.pixelSize: 60
    }

    OwnText {
        text: TimeServices.date
        font.pixelSize: 30
    }

    component OwnText: TextStyled {
        anchors.horizontalCenter: parent.horizontalCenter
        color: Colors.textAccent
    }
}