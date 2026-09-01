pragma Singleton
import Quickshell
import qs.config

Singleton {
    property var __data: ""
    property string __client: ""
    property bool isRetry: false
    property string titleText: ""
    property string placeholder: ""

    function requestPassword(client, data, status) {
        __client = client
        __data = data
        isRetry = status

        if (client === "wifi") {
            titleText = STranslations.tr("wifi_connecting_title"), data.name

            if (!status) {
                placeholder = STranslations.tr("enter_password")
            } else {
                placeholder = STranslations.tr("invalid_password")
            }
        }

        UIState.isAuthenficatorOpen = true
    }

    function enterPassword(password) {
        if (__client === "wifi") {
            SNetwork.connectNetworkWithPsk(__data, password)
        }

        UIState.isAuthenficatorOpen = false
        clear()
    }

    function clear() {
        __data = ""
        __client = ""
        isRetry = false
        titleText = ""
        placeholder = ""
    }
}