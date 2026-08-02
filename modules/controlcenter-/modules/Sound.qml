import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

Item {
    id: root
    width: parent.width

    readonly property real volume: PipewireServices.volume

    RowSpaced {
        ButtonStyled {
            id: leftButton
            height: root.height; width: height
            text: PipewireServices.iconVolume
            onClicked: PipewireServices.toggleMute()
        }

        SliderStyled {
            height: root.height
            width: root.width - leftButton.width - rightButton.width - Global.spacing.large
            from: 0
            to: 1
            value: volume
            onValueChanged: PipewireServices.setVolume(value)
        }

        ButtonStyled {
            id: rightButton
            height: root.height; width: height
            text: "󰁈"
            onClicked: Global.controlCenterModul = "sound"
        }
    }
}