import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.services

ButtonStyled {
    width: parent.width
    text: "Airplane"
    onClicked: AirplaneServices.toggle()
    isActive: AirplaneServices.isAirplaneOn 
    fullH: false
}