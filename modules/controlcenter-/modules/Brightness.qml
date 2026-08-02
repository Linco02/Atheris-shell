import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

Item {
    id: root
    visible: BrightnessServices.isExist
    height: parent.height; width: parent.width

    RowSpaced {
        height: parent.height

        ButtonStyled {
            id: brightnessMin
            height: parent.height; width: height
            text: "󰃞"
            onClicked: BrightnessServices.brightnessSet(0)
        }

        SliderStyled {
            height: parent.height
            width: root.width - brightnessMin.width - brightnessMax.width - Global.spacing.large
            value: BrightnessServices.currentBrigtness
            from: 0; to: 100
            onMoved: {
                BrightnessServices.brightnessSet(value)
            }
        }

        ButtonStyled {
            id: brightnessMax
            height: parent.height; width: height
            text: "󰃠"
            onClicked: BrightnessServices.brightnessSet(100)
        }
    }
}