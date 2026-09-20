import QtQuick
import qs.config
import qs.components.animations

Text {
    color: Theme.colors.textSurface
    font {
        pixelSize: fontSize
        family: Theme.fontFamily
        weight: 600
    }

    property int fontSize: Theme.fontSize

    Behavior on color {ColorAnim {}}
}