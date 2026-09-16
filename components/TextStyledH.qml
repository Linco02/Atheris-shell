import QtQuick
import qs.config
import qs.components.animations

Text {
    color: Theme.colors.textSurface
    font.pixelSize: parent.height - Theme.padding.small
    font.family: Theme.fontFamily
    font.weight: 600

    Behavior on color { ColorAnim {} }
}