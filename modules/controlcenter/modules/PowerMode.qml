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
            model: Global.powerModes
            delegate: ButtonStyled {
                width: root.width / 3; height: root.height
                text: modelData.icon
                onClicked: PerfomanceServices.powerProfile = modelData.label
                isActive: PerfomanceServices.powerProfile === modelData.label
                fullH: false
                
                ToolTipStyled {
                    visible: parent.hovered
                    text: modelData.label
                }
            }
        }
    }
}