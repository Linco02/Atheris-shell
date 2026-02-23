import QtQuick
import qs.components
import qs.settings

RectForeground {
    id: powerWidget
    height: panelHeight - Style.padding2x; width: powerButton.width + Style.padding * 2

    function openExitMenu() {
        if (exitMenuLoader.active) {
            exitMenuLoader.active = false
        } else {
            exitMenuLoader.active = true
        }
    }

    TextStyle2 {
        anchors.centerIn: parent
        id: powerButton
        text: ""
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: powerWidget.color = Style.activeColor
        onExited: powerWidget.color = Style.foreGround
        onClicked: {
            openExitMenu()
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

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