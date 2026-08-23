import QtQuick
import Quickshell
import qs.config
import qs.services
import qs.components
import qs.components.windows
import qs.components.controls
import qs.components.containers

PopFade {
    id: root
    containerH: authenficatorContainer.height
    containerW: authenficatorContainer.width
    positionX: panel.width / 2 - root.width / 2
    position: "top"
    isHorizontalCenter: true
    isOpen: UIState.isAuthenficatorOpen
    onClosedPop: UIState.isAuthenficatorOpen = false

    ColumnStyled {
        id: authenficatorContainer

        TextStyled {text: SAuthenficator.titleText}

        RowStyled {
            TextInputPassword {
                id: password
                height: 40; width: 200
                echoMode: TextInput.Password
                horizontalAlignment: TextInput.AlignHCenter
                placeholderText: SAuthenficator.placeholder
                color: SAuthenficator.isRetry ? Theme.textAccent : Theme.textSurface
                focus: true
                onEntered: SAuthenficator.enterPassword(password.text)
            }

            ButtonStyled {
                id: enterPassword
                height: password.height; width: height
                onClicked: SAuthenficator.enterPassword(password.text)
                text: "󰿄"
            }
        }
    }
}