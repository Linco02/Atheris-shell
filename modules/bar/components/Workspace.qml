import QtQuick
import Quickshell.Hyprland
import qs.config
import qs.components.animations
import qs.components.shapes
import qs.components

RectForeground {
    id: workSpaceWidget
    height: root.height - Appearance.padding.normal; width: wsList.width

    function workspaceMowe(workSpace) {
        if (!workSpace.active) {
            workSpace.activate()
        }
    }

    function activeMove(index) {
        for (let i = 0; i < Hyprland.workspaces.length; i++) {

        }
        // console.log(index)
        activeRect.x = (index - 1) * activeRect.width
    }

    RectActive {
        id: activeRect
        height: workSpaceWidget.height; width: workSpaceWidget.height * 2

        Behavior on x { NumberAnim {} }
    }

    Behavior on width { NumberAnim {} }

    Row {
        id: wsList
        anchors.centerIn: parent

        Repeater {
            model: Hyprland.workspaces

            Rectangle {
                id: workspace
                radius: Appearance.radius.normal
                visible: modelData.id > 0
                height: workSpaceWidget.height; width: height * 2
                color: modelData.urgent ? Appearance.warning :
                    "transparent"

                property bool isActive: modelData.focused ? true : false

                TextStyledH {
                    anchors.centerIn: parent
                    text: modelData.focused ? "●" :
                        modelData.active ? "○" :
                        "◉"
                }

                onIsActiveChanged: {
                    if (isActive)
                        activeMove(modelData.id)
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        if (!modelData.focused)
                            workspace.color = Appearance.active
                    }
                    onExited: {
                        if (!modelData.focused)
                            workspace.color = "transparent"
                    }
                    onClicked: {
                        workspace.color = "transparent"
                        workspaceMowe(modelData)
                    }
                }

                Behavior on color { ColorAnim{ } }
            }
        }
    }
}