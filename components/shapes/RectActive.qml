import QtQuick
import qs.components.animations
import qs.config

Rectangle {
    radius: Global.radius.normal
    color: Colors.active

    Behavior on color { ColorAnim { } }
}