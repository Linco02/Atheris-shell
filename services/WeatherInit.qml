pragma Singleton
import QtQuick

QtObject {
    signal weatherTemp(string temp)
    signal weatherDescription(string description)
    signal weathrIcon(string icon)

    property Timer start: Timer {
        interval: 1800000; running: true; repeat: true
        triggeredOnStart: true
        onTriggered: { fetchWeather() }
    }

    // function fetchWeather() {
    //     let xhr = new XMLHttpRequest();

    //     xhr.open("GET", "https://wttr.in/Cherkasy?format=j1"); 
    //     xhr.onreadystatechange = function() {
    //         if (xhr.readyState === XMLHttpRequest.DONE) {
    //             if (xhr.status === 200) {
    //                 let data = JSON.parse(xhr.responseText)
    //                 let current = data.current_condition[0]

    //                 let temp = current.temp_C
    //                 let description = current.lang_uk ? current.lang_uk[0].value : current.weatherDesc[0].value
    //                 let iconName = current.weatherDesc[0].value

    //                 weatherTemp(temp)
    //                 weatherDescription(description)
    //                 weathrIcon(getWeatherIcon(iconName))
    //             }
    //         }
    //     }
    //     xhr.send()
    // }

    function fetchWeather() {
        let xhr = new XMLHttpRequest();

        xhr.open("GET", "https://wttr.in/Cherkasy?format=j1");
        xhr.timeout = 10000; // 10 сек

        xhr.onreadystatechange = function() {
            if (xhr.readyState !== XMLHttpRequest.DONE)
                return;

            // якщо не 200 — просто мовчимо
            if (xhr.status !== 200)
                return;

            try {
                let data = JSON.parse(xhr.responseText)

                if (!data.current_condition || data.current_condition.length === 0)
                    return;

                let current = data.current_condition[0]

                let temp = current.temp_C
                let description =
                    current.lang_uk
                    ? current.lang_uk[0].value
                    : current.weatherDesc[0].value

                let iconName = current.weatherDesc[0].value

                weatherTemp(temp)
                weatherDescription(description)
                weathrIcon(getWeatherIcon(iconName))

            } catch (e) {
                // якщо JSON битий — просто ігноруємо
                return;
            }
        }

        xhr.onerror = function() {
            // повністю ігноруємо помилки мережі
            return;
        }

        xhr.ontimeout = function() {
            return;
        }

        xhr.send()
    }

    function getWeatherIcon(iconName) {
        const desc = iconName.toLowerCase();
            
        const mapping = {
            "sunny": "weather-clear",
            "clear": "weather-clear",
            "partly cloudy": "weather-few-clouds",
            "cloudy": "weather-clouds",
            "overcast": "weather-overcast",
            "mist": "weather-fog",
            "patchy rain possible": "weather-showers-scattered",
            "patchy snow possible": "weather-snow",
            "patchy sleet possible": "weather-freezing-rain",
            "patchy freezing drizzle possible": "weather-freezing-rain",
            "thundery outbreaks possible": "weather-storm",
            "blowing snow": "weather-snow",
            "blizzard": "weather-snow",
            "fog": "weather-fog",
            "freezing fog": "weather-fog",
            "patchy light drizzle": "weather-showers-scattered",
            "light drizzle": "weather-showers-scattered",
            "freezing drizzle": "weather-freezing-rain",
            "heavy freezing drizzle": "weather-freezing-rain",
            "patchy light rain": "weather-showers",
            "light rain": "weather-showers",
            "moderate rain": "weather-showers",
            "heavy rain": "weather-showers",
            "light freezing rain": "weather-freezing-rain",
            "moderate or heavy freezing rain": "weather-freezing-rain",
            "light sleet": "weather-snow",
            "ice pellets": "weather-snow",
            "light rain shower": "weather-showers",
            "torrential rain shower": "weather-showers",
            "patchy light snow with thunder": "weather-storm"
        };

        if (mapping[desc]) return mapping[desc];
        
        if (desc.includes("rain")) return "weather-showers";
        if (desc.includes("snow")) return "weather-snow";
        if (desc.includes("thunder")) return "weather-storm";
        if (desc.includes("fog") || desc.includes("mist")) return "weather-fog";
        return "weather-few-clouds";
    }

}