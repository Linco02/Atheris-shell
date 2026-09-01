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
        TextInputPassword {
            id: password
            height: root.height; width: root.width - enterPassword.height
            echoMode: TextInput.Password
            horizontalAlignment: TextInput.AlignHCenter
            placeholderText: STranslations.tr("enter_password")
            focus: true
            onEntered: SPam.authenticate(password.text)
        }

        ButtonStyled {
            id: enterPassword
            height: root.height; width: height
            onClicked: SPam.authenticate(password.text)
            text: "󰿄"
        }
    }

    Connections {
        target: SPam
        function onCompleted() { UIState.isSessionLock = false }
        function onError() {
            password.placeholderText = STranslations.tr("invalid_password")
        }
    }
}