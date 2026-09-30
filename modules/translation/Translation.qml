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
    containerH: 200
    containerW: 400
    positionX: 200 / 2 - 400 / 2
    position: "top"
    isHorizontalCenter: true
    isOpen: UIState.isAtherisTranslateOpen
    onClosedPop: {
        UIState.isAtherisTranslateOpen = false
        SAuthenficator.clear()
    }

    TextStyled {
        text: STranslate.text
    }

    // ColumnStyled {
    //     id: authenficatorContainer

    //     TextStyled {text: SAuthenficator.titleText}

    //     RowStyled {
    //         TextInputPassword {
    //             id: password
    //             height: 40; width: 200
    //             echoMode: TextInput.Password
    //             horizontalAlignment: TextInput.AlignHCenter
    //             placeholderText: SAuthenficator.placeholder
    //             color: SAuthenficator.isRetry ? Theme.colors.textAccent : Theme.colors.textSurface
    //             focus: true
    //             onEntered: SAuthenficator.enterPassword(password.text)
    //         }

    //         ButtonStyled {
    //             id: enterPassword
    //             height: password.height; width: height
    //             onClicked: SAuthenficator.enterPassword(password.text)
    //             text: "󰿄"
    //         }
    //     }
    // }
}