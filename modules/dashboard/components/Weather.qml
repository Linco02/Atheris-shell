import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.config
import qs.services
import qs.components.shapes
import qs.components

RectForeground {
    id: weatherWidget
    property string weatherIcom: "emblem-synchronizing"
    property string temp: "--"
    property string description: "Завантаження"

    Connections {
        target: WeatherInit
        function onWeatherTemp(tempData) {
            temp = tempData
        }
        function onWeatherDescription(descriptionData) {
            description = descriptionData
        }
        function onWeathrIcon(weathrIconData) {
            weatherIcom = weathrIconData
        }
    }

    Row {
        anchors.centerIn: parent
        spacing: Appearance.spacing.normal

        IconImage {
            source: Quickshell.iconPath(weatherIcom)
            implicitSize: weatherWidget.height / 2
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            TextStyled {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: weatherWidget.height / 4
                text: temp
            }

            TextStyled {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: weatherWidget.height / 10
                text: description
            }
        }
    }
}