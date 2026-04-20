import QtQuick
import qs.components.shapes
import qs.components.controls
import qs.config
import qs.services

RectForeground {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter
    height: 40; width: 300

    Row {
        TextInputStyled {
            id: password
            height: root.height; width: root.width - enterPassword.height
            echoMode: TextInput.Password
            horizontalAlignment: TextInput.AlignHCenter
            placeholderText: "Enter password"
            focus: true
            onEntered: PamServices.authenticate(password.text)
        }

        ButtonStyled {
            id: enterPassword
            height: root.height; width: height
            onClicked: PamServices.authenticate(password.text)
            text: "󰿄"
        }
    }

    Connections {
        target: PamServices
        function onCompleted() { Global.isSessionLock = false }
        function onError() {
            password.placeholderText = "Invalid password"
        }
    }
}