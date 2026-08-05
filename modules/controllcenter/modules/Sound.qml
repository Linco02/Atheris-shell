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

    readonly property real volume: SPipewire.volume

    RowStyled {
        ButtonStyled {
            id: leftButton
            height: root.height; width: height
            text: SPipewire.iconVolume
            onClicked: SPipewire.toggleMute()
        }

        SliderStyled {
            height: root.height
            width: root.width - leftButton.width - rightButton.width - Style.spacing.large
            from: 0
            to: 1
            value: volume
            onValueChanged: SPipewire.setVolume(value)
        }

        ButtonStyled {
            id: rightButton
            height: root.height; width: height
            text: "󰁈"
            onClicked: UIState.controlCenterModul = "sound"
        }
    }
}