import QtQuick
import Quickshell.Hyprland
import qs.config
import qs.components.animations
import qs.components.shapes
import qs.components

import QtQuick.Controls
import Quickshell

RectForeground {
    id: root
    height: parent.height; width: workspaceContainer.width

    property real cornerRadius: Appearance.radius.normal
    property var workspaceFocused: Hyprland.focusedWorkspace?.id ?? 1
    readonly property int workspaceNumber: 5
    property int workspaceExist: workspaceNumber
    property list<bool> workspaceOccupied: []
    property list<bool> workspaceRadius: []

    Connections {
        target: Hyprland.workspaces
        function onValuesChanged() { updateExist() }
    }

    function updateExist() {
        let maxId = Hyprland.workspaces.values.reduce((max, ws) => {
            return (ws.id > max) ? ws.id : max
        }, 1);
        workspaceExist = Math.max(maxId, workspaceNumber)

        updateOccupied()
    }

    function updateOccupied() {
        workspaceOccupied = Array.from({length: workspaceExist}, (_,i) => {
            return Hyprland.workspaces.values.some(ws => ws.id === (i + 1));
        })
    }

    Row {
        id: workspaceContainer
        
        Repeater {
            model: workspaceExist

            Rect {
                height: root.height; width: 50
                topLeftRadius: leftRad ? 0 : cornerRadius; bottomLeftRadius: leftRad ? 0 : cornerRadius
                topRightRadius: rightRad ? 0 : cornerRadius; bottomRightRadius: rightRad ? 0 : cornerRadius
                color: isOccupied ? Colors.inactive
                    : "transparent"

                property bool isFocused: workspaceFocused === index + 1
                property bool isOccupied: workspaceOccupied[index] || false
                property bool leftRad: isOccupied && (index > 0 && workspaceOccupied[index - 1]) === true
                property bool rightRad: isOccupied && (index < workspaceOccupied.length - 1 && workspaceOccupied[index + 1]) === true

                MouseFill {
                    onClicked: Hyprland.dispatch(`workspace ${index + 1}`)
                }

                Behavior on color { ColorAnim {} }
                Behavior on topLeftRadius { NumberAnim { } }
                Behavior on bottomLeftRadius { NumberAnim { } }
                Behavior on topRightRadius { NumberAnim { } }
                Behavior on bottomRightRadius { NumberAnim { } }
            }
        }
    }

    Rect {
        height: root.height; width: 50
        x: workspaceFocused > 0 ? workspaceFocused * 50 - 50 : 1
        color: Colors.active

        Behavior on x { NumberAnim {} }
    }

    Row {
        Repeater {
            model: workspaceExist

            Item {
                property bool isFocused: workspaceFocused === index + 1
                property bool isOccupied: workspaceOccupied[index] || false
                height: root.height; width: 50

                TextStyledH {
                    anchors.centerIn: parent
                    z: 3
                    text: isFocused ? "●" 
                        : isOccupied ? "◉"
                        : "○"
                    color: isFocused ? Colors.inactive
                        : isOccupied ? Colors.active
                        : Colors.inactive

                    Behavior on color { ColorAnim {} }
                }
            }
        }
    }

    Behavior on width { NumberAnim { } }

    Component.onCompleted: { updateExist() }
}