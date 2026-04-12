import QtQuick
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.config
import qs.services

RectForeground {
    id: root
    height: iconSize; width: height
    color: hover && !active ? Qt.lighter(focused ? Colors.inactive : Colors.surfaceRaised, Global.appearance.hover)
        : active ? Colors.active
        : focused ? Colors.inactive
        : Colors.surfaceRaised

    property alias iconSize: buttonIcon.implicitSize
    property string source: ""
    property bool active: false
    property bool focused: false

    signal clicked()

    IconImage {
        id: buttonIcon
        anchors.centerIn: parent
        source: AppIcons.getIcon(root.source)
        implicitSize: root.height - Global.padding.mini + 2
    }

    TextStyled {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: parent.height - Global.padding.small
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: clicked() }
}