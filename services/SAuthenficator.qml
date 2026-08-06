pragma Singleton
import Quickshell
import qs.config

Singleton {
    property string __data: ""
    property string __client: ""
    property bool isRetry: false
    property string titleText: ""
    property string placeholder: ""

    function requestPassword(client, data, status) {
        __client = client
        __data = data
        isRetry = status

        if (client === "wifi") {
            titleText = "Підключення до wifi", data

            if (!status) {
                placeholder = "Введіть пароль"
            } else {
                placeholder = "Неправельний пароль"
            }
        }

        UIState.isAuthenficatorOpen = true
    }

    function enterPassword(password) {
        if (__client === "wifi") {
            SNetwork.connectWifi(__data, password)
        }

        UIState.isAuthenficatorOpen = false
        __data = ""
    }
}