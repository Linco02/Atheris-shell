import QtQuick
import qs.components.animations
import qs.config

Rectangle {
    radius: Theme.radius.normal
    color: "transparent"

    Behavior on color {ColorAnim {}}
    // Behavior on radius {NumberAnim {}}
}