import QtQuick
import qs.config
import qs.components.animations

Text {
    property int fontSize: Style.fontSize

    color: Theme.textSurface
    font.pixelSize: fontSize
    font.family: Style.fontFamily
    font.weight: 600

    Behavior on color { ColorAnim {} }
}