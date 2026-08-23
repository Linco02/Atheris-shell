import QtQuick
import Quickshell.Widgets
import qs.config
import qs.services
import qs.components
import qs.components.shapes
import qs.components.containers

RectForeground {
    id: root
    color: hover.hovered ? Qt.lighter(Theme.surfaceRaised, Style.hover)
        : Theme.surfaceRaised

    property string icon: ""
    property string textTop: ""
    property string textBottom: ""
    property int iconSize: root.height - Style.padding.mini + 2
    property bool isActive: false

    signal clicked()

    RowStyled {
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: Style.padding.normal; rightPadding: Style.padding.normal
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
                color: isActive ? Theme.textAccent : Theme.textSurface
            }
            TextStyled {
                text: textBottom
            }
        }
    }

    HoverHandler {id: hover}
    TapHandler {onTapped: clicked()}
}