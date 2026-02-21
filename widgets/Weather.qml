import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.settings
import qs.singletons

RectForeground {
    id: weatherWidget
    property string weatherIcom: "emblem-synchronizing"
    property string temp: "--"
    property string description: "Завантаження"

    // Connections {
    //     target: WeatherInit
    //     function onWeatherTemp(tempData) {
    //         temp = tempData
    //     }
    //     function onWeatherDescription(descriptionData) {
    //         description = descriptionData
    //     }
    //     function onWeathrIcon(weathrIconData) {
    //         weatherIcom = weathrIconData
    //     }
    // }

    Row {
        anchors.centerIn: parent
        spacing: Style.spacing

        IconImage {
            source: Quickshell.iconPath(weatherIcom)
            implicitSize: weatherWidget.height / 2
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            TextStyle1 {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: weatherWidget.height / 4
                text: temp
            }

            TextStyle1 {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: weatherWidget.height / 10
                text: description
            }
        }
    }
}