import QtQuick
import qs.components.animations
import qs.config

Rectangle {
    radius: Global.radius.normal
    color: Colors.surfaceRaised

    Behavior on color { ColorAnim { } }
}