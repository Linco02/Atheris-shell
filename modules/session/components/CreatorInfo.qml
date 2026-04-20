import QtQuick
import qs.components
import qs.config

Column {
    OwnText { text: "Atheris-shell | linco02" }
    OwnText { text: "github:Linco02/Atheris-shell" }

    component OwnText: TextStyled {
        anchors.horizontalCenter: parent.horizontalCenter
        color: Colors.textAccent
    }
}