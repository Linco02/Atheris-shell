import QtQuick
import qs.components
import qs.components.controls
import qs.config

ButtonStyled {
    width: parent.width
    fullH: false
    isActive: Global.palitMode === "dark"
    text: Global.palitMode === "dark"
        ? "Dark mode"
        : "Light mode"
    onClicked: {
        if (Global.palitMode === "dark") Global.palitMode = "light"
        else Global.palitMode = "dark"
    }
}