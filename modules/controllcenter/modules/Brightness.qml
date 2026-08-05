import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

Item {
    id: root
    visible: SBrightness.isExist
    height: parent.height; width: parent.width

    RowStyled {
        height: parent.height

        ButtonStyled {
            id: brightnessMin
            height: parent.height; width: height
            text: "󰃞"
            onClicked: SBrightness.brightnessSet(0)
        }

        SliderStyled {
            height: parent.height
            width: root.width - brightnessMin.width - brightnessMax.width - Style.spacing.large
            value: SBrightness.currentBrigtness
            from: 0; to: 100
            onMoved: {
                SBrightness.brightnessSet(value)
            }
        }

        ButtonStyled {
            id: brightnessMax
            height: parent.height; width: height
            text: "󰃠"
            onClicked: SBrightness.brightnessSet(100)
        }
    }
}