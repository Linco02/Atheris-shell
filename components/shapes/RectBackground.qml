import QtQuick
import qs.components.animations
import qs.config

Rectangle {
    radius: Global.radius.normal
    color: Qt.alpha(Colors.surface, Global.appearance.opacity)

    Behavior on color { ColorAnim { } }
}