import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.services

ButtonStyled {
    width: parent.width
    text: "Airplane"
    onClicked: NotificationServices.send("test", "airplane", "low")
    fullH: false
}