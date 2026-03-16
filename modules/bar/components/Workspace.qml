import QtQuick
import Quickshell.Hyprland
import qs.config
import qs.components.animations
import qs.components.shapes
import qs.components

RectForeground {
    id: root
    height: parent.height; width: workspaceContainer.width

    property var wsActive: Hyprland.focusedWorkspace.id

    onWsActiveChanged: {
        workspaceDecoration(wsActive)
    }

    function workspaceActivate(index) {
        if (Hyprland.focusedWorkspace.id !== index) {
            Hyprland.dispatch(`workspace ${index}`)
        } else
            return
    }

    function workspaceDecoration(index) {
        workspaceDecorate.x = index * 50 - 50
    }

    RectActive {
        id: workspaceDecorate
        height: root.height; width: 50

        Behavior on x { NumberAnim {} }
    }

    Row {
        id: workspaceContainer
        height: parent.height

        Repeater {
            model: 10

            Rect {
                height: root.height; width: 50
                visible: index <= 4 || Hyprland.focusedWorkspace.id >= index + 1

                TextStyledH {
                    anchors.centerIn: parent
                    text: Hyprland.focusedWorkspace.id !== index + 1
                        ? "○"
                        : "●"
                }

                MouseFill {
                    onClicked: workspaceActivate(index + 1)
                }
            }
        }
    }

    Behavior on width { NumberAnim {} }

    Repeater {
        model: Hyprland.workspaces

        Item {
            Component.onCompleted: {
                console.log(modelData.name)
            }
        }
    }
}