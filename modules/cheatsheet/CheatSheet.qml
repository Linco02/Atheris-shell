import QtQuick
import Quickshell
import qs.config
import qs.services
import qs.components
import qs.components.shapes
import qs.components.windows
import qs.components.controls
import qs.components.containers

PopFade {
    id: root
    containerH: cheatSheetContainer.height
    containerW: cheatSheetContainer.width
    positionX: panel.width / 2 - root.width / 2
    position: "top"
    isHorizontalCenter: true
    isOpen: UIState.ischeatsheetopen
    onClosedPop: UIState.ischeatsheetopen = false

    ListView {
        id: cheatSheetContainer
        height: 1000; width: 700
        orientation: ListView.Vertical
        // interactive: true
        spacing: Theme.spacing.normal

        model: SCheatSheet.bindList
        delegate: RectForeground {
            height: 40; width: 600
            anchors.horizontalCenter: parent.horizontalCenter

            Row {
                spacing: 20
                TextStyled {text: modelData.mod}
                TextStyled {text: modelData.key}
                TextStyled {text: modelData.dispatcher}
                TextStyled {text: modelData.arg}
            }

        }
    }

}