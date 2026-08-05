pragma Singleton
import Quickshell
import qs.config

Singleton {
    property string __data: ""
    property string titleText: ""

    function requestPassword(client, data) {
        if (client === "wifi") {
            __data = data
            titleText = "Підключення до wifi", data
        }
        // __command = data

        UIState.isAuthenficatorOpen = true
    }

    function enterPassword(password) {
        SNetwork.connectWifi(__data, password)
        __data = ""
    }
}