import QtQuick
import Quickshell.Widgets
import qs.config
import qs.services
import qs.components
import qs.components.shapes
import qs.components.containers

RectForeground {
    id: root
    color: hover.hovered ? Qt.lighter(Theme.colors.surfaceRaised, Theme.hover)
        : Theme.colors.surfaceRaised

    property string icon: ""
    property string textTop: ""
    property string textBottom: ""
    property int iconSize: root.height - Theme.padding.mini + 2
    property bool isActive: false

    signal clicked()

    RowStyled {
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: Theme.padding.normal; rightPadding: Theme.padding.normal
        height: parent.height
        clip: true

        IconImage {
            id: buttonIcon
            source: SIcon.getIcon(root.icon)
            implicitSize: iconSize 
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            TextStyled {
                text: textTop
                color: isActive ? Theme.colors.textAccent : Theme.colors.textSurface
            }
            TextStyled {
                text: textBottom
            }
        }
    }

    HoverHandler {id: hover}
    TapHandler {onTapped: clicked()}
}