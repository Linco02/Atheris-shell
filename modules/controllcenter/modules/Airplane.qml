import QtQuick
import qs.services
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.services

ButtonStyled {
    width: parent.width
    text: STranslations.tr("airplane")
    onClicked: SAirplane.toggle()
    isActive: SAirplane.isAirplaneOn 
    fillH: false
}