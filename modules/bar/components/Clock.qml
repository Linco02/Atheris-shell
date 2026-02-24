import QtQuick
import qs.services
import qs.config
import qs.components.shapes
import qs.components.animations
import qs.components

RectForeground {
    height: root.height - Appearance.padding.normal; width: clockText.width + Appearance.padding.large
    
    property string time: ""

    Connections {
        target: Time
        function onTime(data) {
            time = data
        }
    }

    TextStyledH {
        id: clockText
        anchors.centerIn: parent
        text: time
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            parent.color = Appearance.active
            clockText.color = Appearance.surface
        }
        onExited: {
            parent.color = Appearance.surfaceRaised
            clockText.color = Appearance.textSurface
        }
        // onClicked: controlCenter.openMenu()
    }

    Behavior on color { ColorAnim{ } }

    // DashBoardCenter {
    //     id: controlCenter
    // }
}