import QtQuick
import qs.components
import qs.components.shapes
import qs.config
import qs.services

RectForeground {
    id: root

    Row {
        anchors.centerIn: parent
        spacing: Style.spacing.normal

        TextStyled {
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.height / 2 || 20
            text: STime.isDay ? "" : ""
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: Style.spacing.normal

            TextStyled {
                anchors.horizontalCenter: parent.horizontalCenter
                text: STime.time
            }

            TextStyled {
                anchors.horizontalCenter: parent.horizontalCenter
                text: STime.date
            }
        }
    }
}