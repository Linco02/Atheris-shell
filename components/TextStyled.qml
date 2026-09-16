import QtQuick
import qs.config
import qs.components.animations

Text {
    property int fontSize: Theme.fontSize

    color: Theme.colors.textSurface
    font.pixelSize: fontSize
    font.family: Theme.fontFamily
    font.weight: 600

    Behavior on color { ColorAnim {} }
}