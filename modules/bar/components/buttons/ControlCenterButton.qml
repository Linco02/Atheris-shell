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
            controlcenterWidget.color = Colors.active
        }
        onExited: {
            controlcenterWidget.color = Colors.surfaceRaised
        }
        onClicked: {
            controlcenter.openMenu()
        }
    }

    Behavior on color { ColorAnim{ } }

    ControlCenter {
        id: controlcenter
    }
}