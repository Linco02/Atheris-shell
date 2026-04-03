import QtQuick
import qs.components.animations
import qs.config

Rectangle {
    radius: Global.radius.normal
    color: Colors.surface
    opacity: Global.appearance.opacity

    Behavior on color { ColorAnim { } }
}