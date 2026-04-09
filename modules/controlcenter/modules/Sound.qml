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
    // property window

    RowSpaced {
        ButtonStyled {
            id: leftButton
            height: root.height; width: height
            text: PipewireServices.iconVolume
            onLeftClicked: PipewireServices.toggleMute()
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
            onLeftClicked: Global.controlCenterModul = "sound"
        }
    }
}