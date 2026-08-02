import QtQuick
import qs.config
import qs.components.animations

Text {
    color: Theme.textSurface
    font.pixelSize: Style.fontSize
    font.family: Style.fontFamily
    font.weight: 600

    Behavior on color { ColorAnim {} }
}