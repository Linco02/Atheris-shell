import QtQuick
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.config
import qs.services

RectForeground {
    id: root
    height: iconSize; width: height
    color: hover && !active ? Qt.lighter(focused ? Theme.inactive : Theme.surfaceRaised, Style.hover)
        : active ? Theme.active
        : focused ? Theme.inactive
        : Theme.surfaceRaised

    property alias iconSize: buttonIcon.implicitSize
    property string source: ""
    property bool active: false
    property bool focused: false

    signal clicked()

    IconImage {
        id: buttonIcon
        anchors.centerIn: parent
        source: SAppIcons.getIcon(root.source)
        implicitSize: root.height - Style.padding.mini + 2
    }

    TextStyled {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: parent.height - Style.padding.small
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: clicked() }
}