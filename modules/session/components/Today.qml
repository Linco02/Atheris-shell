import QtQuick
import qs.components
import qs.config
import qs.services

Column {
    anchors.horizontalCenter: parent.horizontalCenter

    OwnText {
        text: STime.time
        font.pixelSize: 60
    }

    OwnText {
        text: STime.date
        font.pixelSize: 30
    }

    component OwnText: TextStyled {
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.textAccent
    }
}