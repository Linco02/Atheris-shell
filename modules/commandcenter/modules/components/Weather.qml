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
        spacing: Global.spacing.normal

        IconImage {
            anchors.verticalCenter: parent.verticalCenter
            source: WeatherServices.weatherIcom
            implicitSize: root.height / 2
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            TextStyled {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: root.height / 4 || 20
                text: WeatherServices.temp
            }

            TextStyled {
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.width / 2
                font.pointSize: root.height / 10 || 20
                text: WeatherServices.description
                wrapMode: Text.Wrap
            }
        }
    }
}