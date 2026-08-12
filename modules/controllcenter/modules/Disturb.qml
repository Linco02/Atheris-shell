import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.config
import qs.services

ButtonStyled {
    width: parent.width
    text: "Disturb"
    onClicked: SDnd.dndToggle()
    isActive: Settings.isDndOn 
    fillH: false
}