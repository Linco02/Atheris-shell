import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.config
import qs.services

RectInactive {
    id: root
    width: parent.width

    Row {
        Repeater {
            model: Icon.powerModes
            delegate: ButtonStyled {
                width: root.width / 3; height: root.height
                text: modelData.icon
                onClicked: SPerfomance.powerProfile = modelData.label
                isActive: SPerfomance.powerProfile === modelData.label
                fullH: false
                
                ToolTipStyled {
                    visible: parent.hovered
                    text: modelData.label
                }
            }
        }
    }
}