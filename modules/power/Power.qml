import QtQuick
import Quickshell
import qs.config
import qs.services
import qs.components.windows
import qs.components.controls
import qs.components.containers

PopFade {
    id: root
    containerH: powerContainer.height
    containerW: powerContainer.width
    positionX: panel.width / 2 - root.width / 2
    isHorizontalCenter: true
    isOpen: UIState.power.isOpen
    onClosedPop: UIState.power.isOpen = false

    RowStyled {
        id: powerContainer

        Repeater {
            model: SSession.actions

            ButtonStyled {
                height: 60; width: height
                text: modelData.icon
                radius: height - 5
                onClicked: SSession.choseAction(modelData)
            }
        }
    }
}