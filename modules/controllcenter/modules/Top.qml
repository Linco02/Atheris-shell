import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

Rect {
    id: root
    width: parent.width

    RectInactive {
        visible: SUPower.isExist
        height: parent.height
        width: buttery.width + Style.padding.large

        TextStyled {
            id: buttery
            anchors.centerIn: parent
            font.pixelSize: parent.height - Style.padding.large
            text: SUPower.batteryLevelRound + "% " + SUPower.batteryIcon
        }
    }

    RowStyled {
        anchors.right: parent.right
        height: parent.height

        ButtonStyled {
            height: parent.height; width: height
            text: ""
            onClicked: SWManager.atherisSettings("general")
        }

        ButtonStyled {
            height: parent.height; width: height
            text: ""
            onClicked: UIState.isPowerOpen = !UIState.isPowerOpen
        }
    }
}