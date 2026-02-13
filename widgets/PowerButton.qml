import QtQuick
import qs.components
import qs.settings

RectForeground {
    id: root
    height: panelHeight - Style.padding2x; width: powerButton.width + Style.padding * 2

    TextStyle2 {
        anchors.centerIn: parent
        id: powerButton
        text: ""
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.color = Style.activeColor
        onExited: root.color = Style.foreGround
        onClicked: {
            exitMenuLoader.active = true
            exitMenu.visible = true
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