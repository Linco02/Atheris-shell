import QtQuick
import qs.components
import qs.components.controls
import qs.config

ButtonStyled {
    width: parent.width
    fullH: false
    isActive: Settings.palitMode === "dark"
    text: Settings.palitMode === "dark"
        ? "Dark mode"
        : "Light mode"
    onClicked: {
        if (Settings.palitMode === "dark") Settings.palitMode = "light"
        else Settings.palitMode = "dark"
    }
}