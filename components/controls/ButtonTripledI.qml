import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.config

RectInactive {
    id: root
    color: hover.hovered && !isActive ? Qt.lighter(Theme.inactive, Style.hover)
        : isActive ? Theme.active
        : Theme.inactive

    property string icon: ""
    property string textTop: ""
    property string textBottom: ""
    property bool isActive: false

    signal clicked()

    RowStyled {
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: Style.padding.normal; rightPadding: Style.padding.normal
        height: parent.height
        clip: true

        IconImage {
            anchors.verticalCenter: parent.verticalCenter
            source: Quickshell.iconPath(icon)
            implicitSize: parent.height - Style.padding.small
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            TextOwn { text: textTop }
            TextOwn { text: textBottom }
        }
    }
    
    component TextOwn: TextStyled {
        color: isActive ? Theme.textAccent : Theme.textSurface
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: clicked() }
}