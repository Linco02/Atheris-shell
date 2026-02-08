import QtQuick
import Quickshell.Hyprland
import qs.settings
import qs.components

RectForeground {
    id: root
    height: 20; width: 120
    Row {
        Repeater {
            model: Hyprland.workspaces

            Rectangle {
                visible: modelData.id > 0
                height: root.height; width: root.height
                color: modelData.focused ? Style.activeColor :
                       modelData.urgent ? "red" :
                       "transparent"

                Text {
                    anchors.centerIn: parent
                    text: modelData.focused ? "●" :
                       modelData.active ? "○" :
                       "◉"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: modelData.activate()
                }
            }
        }
    }
}