pragma Singleton
import Quickshell

Singleton {
    id: root

    readonly property var languages: ["en", "uk"]
    property string currentLanguage: "uk"

    property var dict: ({
        "uk": {
            "search_placeholder": "Поле пошуку",
            "scanning": "Сканування пристроїв",
            "connect": "Під'єднатися",
            "disconnect": "Від'єднатися",
            "paired_devices": "Сполучені пристрої",
            "available_devices": "Доступні пристрої",
            "update": "Оновлення",
            "reset": "Скинути",
            "resume": "Продовжити",
            "start": "Запустити",
            "stop": "Зупинити",

            // password
            "enter_password": "Введіть пароль",
            "invalid_password": "Невірний пароль",

            // Bluetooth
            "bluetooth": "Bluetooth",
            "bluetooth_discoverable": "Виявлення іншими пристроями",
            "bluetooth_pairable": "Дозволено сполучення іншим пристроям",

            // Wifi
            "wifi": "Wifi",
            "wifi_connecting_title": "Підключення до wifi",
            "wifi_active_network": "Активна мережа",
            "wifi_available_networks": "Доступні мережі",

            // Airplane
            "airplane": "Режим літака",

            // Disturb
            "disturb": "Не турбувати",

            // Time
            "clock_timer": "Таймер",
            "clock_stopwatch": "Секундомір",
            "clock_alarm": "Будильник",
        },
        "en": {
            "search_placeholder": "Search field",
            "scanning": "Scanning devices",
            "connect": "Connect",
            "disconnect": "Disconnect",
            "paired_devices": "Paired devices",
            "available_devices": "Available devices",
            "update": "Update",
            "reset": "Reset",
            "resume": "Resume",
            "start": "Start",
            "stop": "Stop",

            // password
            "enter_password": "Enter password",
            "invalid_password": "Invalid password",

            // Bluetooth
            "bluetooth": "Bluetooth",
            "bluetooth_discoverable": "Discoverable by other devices",
            "bluetooth_pairable": "Allow pairing from other devices",

            // Wifi
            "wifi": "Wifi",
            "wifi_connecting_title": "Connecting to wifi",
            "wifi_active_network": "Active network",
            "wifi_available_networks": "Available networks",

            // Airplane
            "airplane": "Airplane",

            // Disturb
            "disturb": "Disturb",

            // Time
            "clock_timer": "Timer",
            "clock_stopwatch": "Stopwatch",
            "clock_alarm": "Alarm",
        }
    })

    function tr(key) {
        const d = dict[currentLanguage]
        return (d && d[key] !== undefined) ? d[key] : key
    }

    function setLanguage(language) {
        if (languages.includes(language)) {
            currentLanguage = language
        }
    }
}