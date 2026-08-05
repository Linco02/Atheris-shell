import QtQuick
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.config
import qs.services

RectForeground {
    id: root

    Row {
        id: weather
        anchors.centerIn: parent
        spacing: Style.spacing.normal

        IconImage {
            anchors.verticalCenter: parent.verticalCenter
            source: SWeather.weatherIcom
            implicitSize: root.height / 2
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            TextStyled {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: root.height / 4 || 20
                text: SWeather.temp
            }

            TextStyled {
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.width / 2
                font.pixelSize: root.height / 10 || 20
                text: SWeather.description
                wrapMode: Text.Wrap
            }
        }
    }
}