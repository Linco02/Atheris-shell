import QtQuick
import qs.config
import qs.components.animations
import qs.components.shapes
import qs.components

RectForeground {
    id: powerWidget
    height: root.height - Appearance.padding.normal
    width: height + Appearance.padding.normal
    radius: height / 2

    function openExitMenu() {
        if (exitMenuLoader.active) {
            exitMenuLoader.active = false
        } else {
            exitMenuLoader.active = true
        }
    }

    TextStyledH {
        id: powerButton
        anchors.centerIn: parent
        text: ""
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            powerWidget.color = Colors.active
        }
        onExited: {
            powerWidget.color = Colors.surfaceRaised
        }
        onClicked: {
            openExitMenu()
        }
    }

    Behavior on color { ColorAnim{ } }

    Loader {
        id: exitMenuLoader
        active: false
        sourceComponent: Component {
            ExitMenu {
                id: exitMenu
            }
        }
    }
}