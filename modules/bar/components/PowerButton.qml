import QtQuick
import qs.config
import qs.components.animations
import qs.components.shapes
import qs.components

RectForeground {
    id: powerWidget
    height: parent.height
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
            // openExitMenu()
            exitMenu.openMenu()
        }
    }

    Behavior on color { ColorAnim{ } }

    // Loader {
    //     id: exitMenuLoader
    //     active: true
    //     sourceComponent: Component {
    //         ExitMenu {
    //             id: exitMenu
    //         }
    //     }
    // }

    ExitMenu {
        id: exitMenu
    }
}