import QtQuick
import Quickshell
import Quickshell.Io
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.components.animations
import qs.config
import qs.services

RectForeground {
    id: root
    height: parent.height; width: volumeContainer.width + Global.padding.normal

    readonly property real volume: PipewireServices.volume
    property bool isvolumeSliderOpen: false

    SpacedRow {
        id: volumeContainer
        anchors {
            verticalCenter: root.verticalCenter
            right: root.right
        }

        TextStyledH {
            anchors.verticalCenter: parent.verticalCenter
            id: volumeLevelText
            text: Math.floor(volume * 100) + "%"
        }

        SliderStyled {
            anchors.verticalCenter: parent.verticalCenter
            width: isvolumeSliderOpen ? 200 : 0
            opacity: isvolumeSliderOpen ? 1 : 0
            from: 0
            to: 1
            value: volume
            onValueChanged: PipewireServices.setVolume(value)
        }

        ButtonStyled {
            id: volumeText
            anchors.verticalCenter: parent.verticalCenter
            height: root.height
            text: PipewireServices.muted ? "󰖁" : "󰕾"
            onLeftClicked: isvolumeSliderOpen = !isvolumeSliderOpen
            onMiddleClicked: PipewireServices.pavucontrolOpen()
            onRightClicked: PipewireServices.toggleMute()
        }
    }

    Timer {
        id: closeVolumeSlider
        interval: 300
        onTriggered: isvolumeSliderOpen = false
    }

    HoverHandler {
        onHoveredChanged: {
            if(!hovered) closeVolumeSlider.start()
            else closeVolumeSlider.stop()
        }
    }
}