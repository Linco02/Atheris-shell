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
    isOpen: UIState.ischeatsheetopen
    onClosedPop: UIState.isAuthenficatorOpen = false

    ColumnStyled {

    }
}