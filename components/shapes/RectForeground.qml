import QtQuick
import qs.components.animations
import qs.config

Rectangle {
    radius: Style.radius.normal
    color: Theme.colors.surfaceRaised

    Behavior on color { ColorAnim { } }
}