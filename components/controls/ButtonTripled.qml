import QtQuick
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

        TextStyledH {
            anchors.verticalCenter: parent.verticalCenter
            text: icon
            color: isActive ? Theme.textAccent : Theme.textSurface
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