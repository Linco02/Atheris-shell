import QtQuick
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.config
import qs.services

RectForeground {
    id: root
    height: iconSize; width: height
    color: hover && !active ? Qt.lighter(focused ? Theme.colors.inactive : Theme.colors.surfaceRaised, Theme.hover)
        : active ? Theme.colors.active
        : focused ? Theme.colors.inactive
        : Theme.colors.surfaceRaised

    property alias iconSize: buttonIcon.implicitSize
    property string source: ""
    property bool active: false
    property bool focused: false

    signal clicked()

    IconImage {
        id: buttonIcon
        anchors.centerIn: parent
        source: SIcon.getIcon(root.source)
        implicitSize: root.height - Theme.padding.mini + 2
    }

    TextStyled {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: parent.height - Theme.padding.small
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: clicked() }
}