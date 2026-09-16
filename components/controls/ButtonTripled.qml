import QtQuick
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.config

RectInactive {
    id: root
    color: hover.hovered && !isActive ? Qt.lighter(Theme.colors.inactive, Theme.hover)
        : isActive ? Theme.colors.active
        : Theme.colors.inactive

    property string icon: ""
    property string textTop: ""
    property string textBottom: ""
    property bool isActive: false

    signal clicked()

    RowStyled {
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: Theme.padding.normal; rightPadding: Theme.padding.normal
        height: parent.height
        clip: true

        TextStyledH {
            anchors.verticalCenter: parent.verticalCenter
            text: icon
            color: isActive ? Theme.colors.textAccent : Theme.colors.textSurface
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            TextOwn { text: textTop }
            TextOwn { text: textBottom }
        }
    }
    
    component TextOwn: TextStyled {
        color: isActive ? Theme.colors.textAccent : Theme.colors.textSurface
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: clicked() }
}