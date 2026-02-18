import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.settings

RectForeground {
    id: weatherWidget
    property string weatherIcom: "weather-few-clouds"
    property string temp: "--"
    property string description: "Завантаження"

    function getWeatherIcon(description) {
        let desc = description.toLowerCase();
        let isDay = true
        
        if (desc.includes("clear") || desc.includes("sunny")) {
            weatherIcom = isDay ? "weather-clear-sunny" : "weather-clear-night";
        }
        if (desc.includes("cloud")) {
            weatherIcom = isDay ? "weather-clouds" : "weather-clouds-night";
        }
        if (desc.includes("rain") || desc.includes("shower")) {
            weatherIcom = "weather-showers-scattered";
        }
        if (desc.includes("snow")) {
            weatherIcom = "weather-snow";
        }
        if (desc.includes("thunder") || desc.includes("storm")) {
            weatherIcom = "weather-storm";
        }
        
        weatherIcom = "weather-few-clouds"; // Дефолтна іконка
    }

    function fetchWeather() {
        let xhr = new XMLHttpRequest();

        xhr.open("GET", "https://wttr.in/Cherkasy?format=j1"); 
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    let data = JSON.parse(xhr.responseText)
                    let current = data.current_condition[0]

                    temp = current.temp_C + "°C"
                    description = current.lang_uk ? current.lang_uk[0].value : current.weatherDesc[0].value
                }
            }
        }
        xhr.send()
        getWeatherIcon(description)
    }

    Timer {
        interval: 1800000; running: true; repeat: true
        triggeredOnStart: true
        onTriggered: {
            fetchWeather()
            getWeatherIcon(description)
        }
    }

    Timer {
        interval: 10000; running: true
        onTriggered: getWeatherIcon(description)
    }

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