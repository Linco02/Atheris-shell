import QtQuick
import qs.services
import qs.config
import qs.components.shapes
import qs.components.animations
import qs.components
import qs.modules.dashboard

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

    DashBoard {
        id: controlCenter
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            parent.color = Colors.active
        }
        onExited: {
            parent.color = Colors.surfaceRaised
        }
        onClicked: controlCenter.openMenu()
    }

    Behavior on color { ColorAnim{ } }
}