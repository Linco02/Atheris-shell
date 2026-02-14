import QtQuick
import Quickshell.Hyprland
import qs.settings
import qs.components

RectForeground {
    id: workSpaceWidget
    height: panelHeight - Style.padding2x; width: wsList.width

    function workspaceMowe(workSpace) {
        if (!workSpace.active) {
            workSpace.activate()
        }
    }

    Row {
        id: wsList
        anchors.centerIn: parent

        Repeater {
            model: Hyprland.workspaces

            Rectangle {
                radius: Style.radius
                visible: modelData.id > 0
                height: workSpaceWidget.height; width:  modelData.activate ? workSpaceWidget.height * 2 : workSpaceWidget.height
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
                    onClicked: workspaceMowe(modelData)
                }
            }
        }
    }
}