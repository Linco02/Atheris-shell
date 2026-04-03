import QtQuick
import qs.components
import qs.components.shapes
import qs.components.animations
import qs.config
import qs.services

RectForeground {
    id: root
    height: parent.height; width: workspaceContainer.width

    property real cornerRadius: Global.radius.normal
    property var workspaceFocused: WorkspaceService.workspaceFocused
    property int workspaceExist: WorkspaceService.workspaceExist
    property list<bool> workspaceOccupied: WorkspaceService.workspaceOccupied

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
                property bool isOccupied: workspaceOccupied[index]
                property bool leftRad: isOccupied && (index > 0 && workspaceOccupied[index - 1]) === true
                property bool rightRad: isOccupied && (index < workspaceOccupied.length - 1 && workspaceOccupied[index + 1]) === true

                MouseFill { onClicked: WorkspaceService.workspaceMove(index) }

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
        x: workspaceFocused > 0 ? (workspaceFocused - 1) * 50 : 0
        color: Colors.active

        Behavior on x { NumberAnim {} }
    }

    Row {
        Repeater {
            model: workspaceExist

            Item {
                property bool isFocused: workspaceFocused === index + 1
                property bool isOccupied: workspaceOccupied[index]
                height: root.height; width: 50

                TextStyledH {
                    z: 3
                    text: isFocused ? "●" 
                        : isOccupied ? "◉"
                        : "○"
                    color: isFocused ? Colors.inactive
                        : isOccupied ? Colors.textSurface
                        : Colors.inactive

                    Behavior on color { ColorAnim {} }
                }
            }
        }
    }

    Behavior on width { NumberAnim { } }
}