import QtQuick
import Quickshell.Hyprland
import qs.settings
import qs.components

RectForeground {
    id: root
    height: 20; width: wsList.width + Style.padding * 2
    Row {
        id: wsList
        // x: Style.padding
        anchors.centerIn: parent
        Repeater {
            model: Hyprland.workspaces

            Rectangle {
                radius: 10
                visible: modelData.id > 0
                height: root.height; width: root.height
                color: modelData.focused ? Style.activeColor :
                       modelData.urgent ? "red" :
                       "transparent"

                TextStyle2 {
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