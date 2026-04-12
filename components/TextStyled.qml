import QtQuick
import qs.config
import qs.components.animations

Text {
    color: Colors.textSurface
    font.pixelSize: Global.appearance.fontSize
    font.family: Global.appearance.fontFamily
    font.weight: 600

    Behavior on color { ColorAnim {} }
}