import QtQuick
import qs.components.animations
import qs.config

Rectangle {
    radius: Style.radius.normal
    color: Theme.surface

    Behavior on color { ColorAnim { } }
}