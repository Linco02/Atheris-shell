import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.animations
import qs.config

ButtonTransparent {
    id: root
    text: ""
    onLeftClicked: Global.isPowerOpen = true
}