import QtQuick
import qs.config
import qs.components.animations
import qs.components.shapes
import qs.components
import qs.modules.controlcenter

RectForeground {
    id: controlcenterWidget
    height: root.height - Appearance.padding.normal
    width: height + Appearance.padding.normal

    TextStyledH {
        anchors.centerIn: parent
        text: ""
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            controlcenterWidget.color = Appearance.active
        }
        onExited: {
            controlcenterWidget.color = Appearance.surfaceRaised
        }
        onClicked: {
            
        }
    }

    Behavior on color { ColorAnim{ } }

    ControlCenter {
        
    }
}