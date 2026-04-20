import QtQuick
import qs.components.controls
import qs.components.containers
import qs.services

RowSpaced {
    anchors.horizontalCenter: parent.horizontalCenter
    
    Repeater {
        model: SessionServices.actions.filter(a => a.command !== null)

        ButtonStyled {
            height: 40; width: height
            text: modelData.icon
            onClicked: SessionServices.choseAction(modelData)
        }
    }
}