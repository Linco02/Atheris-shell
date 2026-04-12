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
        visible: UPowerServices.isExist
        height: parent.height
        width: buttery.width + Global.padding.large

        TextStyled {
            id: buttery
            anchors.centerIn: parent
            font.pixelSize: parent.height - Global.padding.large
            text: UPowerServices.batteryLevelRound + "% " + UPowerServices.batteryIcon
        }
    }

    RowSpaced {
        anchors.right: parent.right
        height: parent.height

        ButtonStyled {
            height: parent.height; width: height
            text: ""
            onClicked: Global.isAtherisSettingsOpen = !Global.isAtherisSettingsOpen
        }

        ButtonStyled {
            height: parent.height; width: height
            text: ""
            onClicked: Global.isPowerOpen = !Global.isPowerOpen
        }
    }
}