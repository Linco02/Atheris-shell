import QtQuick
import qs.config
import qs.components.animations
import qs.components.shapes
import qs.components

RectForeground {
    id: powerWidget
    height: root.height - Appearance.padding.normal; width: powerButton.width + Appearance.padding.normal
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
        text: ""
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            powerButton.color = Appearance.surfaceRaised
            powerWidget.color = Appearance.active
        }
        onExited: {
            powerButton.color = Appearance.textSurface
            powerWidget.color = Appearance.surfaceRaised
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