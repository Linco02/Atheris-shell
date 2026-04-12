import QtQuick
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.config

RectInactive {
    id: root
    color: hover.hovered && !isActive ? Qt.lighter(Colors.inactive, Global.appearance.hover)
        : isActive ? Colors.active
        : Colors.inactive

    property string icon: ""
    property string textTop: ""
    property string textBottom: ""
    property bool isActive: false

    signal clicked()

    RowSpaced {
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: Global.padding.normal; rightPadding: Global.padding.normal
        height: parent.height
        clip: true

        TextStyledH {
            anchors.verticalCenter: parent.verticalCenter
            text: icon
            color: isActive ? Colors.textAccent : Colors.textSurface
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            TextOwn { text: textTop }
            TextOwn { text: textBottom }
        }
    }
    
    component TextOwn: TextStyled {
        color: isActive ? Colors.textAccent : Colors.textSurface
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: clicked() }
}