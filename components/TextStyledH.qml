import QtQuick
import qs.config
import qs.components
import qs.components.animations

TextStyled {
    font.pixelSize: isHorizontal
        ? parent.height - Theme.padding.small
        : parent.width - Theme.padding.small

    property bool isHorizontal: true
}