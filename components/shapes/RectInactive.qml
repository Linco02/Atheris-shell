import QtQuick
import qs.components.animations
import qs.config

Rectangle {
    radius: Style.radius.normal
    color: Theme.inactive

    Behavior on color { ColorAnim { } }
}