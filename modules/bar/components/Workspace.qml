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

    readonly property int workspaceNumber: 5
    property int workspaceExist: workspaceNumber
    property list<bool> workspaceOccupied: []

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

    // Row {
    //     Repeater {
    //         model: workspaceExist

    //         Item {
    //             property bool isFocused: Hyprland.focusedWorkspace.id === index + 1
    //             property bool isOccupied: workspaceOccupied[index] || false
    //             height: root.height; width: 50

    //             TextStyledH {
    //                 anchors.centerIn: parent
    //                 z: 3
    //                 text: isFocused ? "●" 
    //                     : isOccupied ? "◉"
    //                     : "○"
    //                 color: isFocused ? Colors.inactive
    //                     : isOccupied ? Colors.active
    //                     : Colors.inactive
    //             }
    //         }
    //     }
    // }

    // Rect {
    //     height: root.height; width: 50
    //     color: "red"
    // }

    Row {
        id: workspaceContainer
        
        Repeater {
            model: workspaceExist

            Rect {
                property bool isFocused: Hyprland.focusedWorkspace.id === index + 1
                property bool isOccupied: workspaceOccupied[index] || false

                height: root.height; width: 50
                z: 1
                color: isFocused ? Colors.active
                    : isOccupied ? Colors.inactive
                    : "transparent"

                TextStyledH {
                    anchors.centerIn: parent
                    z: 3
                    text: isFocused ? "●" 
                        : isOccupied ? "◉"
                        : "○"
                    color: isFocused ? Colors.inactive
                        : isOccupied ? Colors.active
                        : Colors.inactive
                }
            }
        }
    }

    Component.onCompleted: { updateExist() }

    // property var wsActive: Hyprland.focusedWorkspace.id
    // property int wsLast: 1

    // onWsActiveChanged: {
    //     workspaceDecoration(wsActive)
    // }

    // function workspaceActivate(index) {
    //     if (Hyprland.focusedWorkspace.id !== index) {
    //         Hyprland.dispatch(`workspace ${index}`)
    //     } else
    //         return
    // }

    // function workspaceDecoration(index) {
    //     workspaceDecorate.x = index * 50 - 50
    // }

    // RectActive {
    //     id: workspaceDecorate
    //     height: root.height; width: 50

    //     Behavior on x { NumberAnim {} }
    // }

    // Row {
    //     id: workspaceContainer
    //     height: parent.height

    //     Repeater {
    //         model: 10

    //         Rect {
    //             height: root.height; width: 50
    //             visible: index <= 4 || index + 1 <= Hyprland.focusedWorkspace.id || index <= wsLast

    //             TextStyledH {
    //                 anchors.centerIn: parent
    //                 text: Hyprland.focusedWorkspace.id !== index + 1
    //                     ? "○"
    //                     : "●"
    //             }

    //             MouseFill {
    //                 onClicked: workspaceActivate(index + 1)
    //             }
    //         }
    //     }
    // }


    // Repeater {
    //     model: Hyprland.workspaces

    //     Rect {
    //         visible: modelData.name > 0 ? true : false
    //         height: root.height; width: 50
    //         x: modelData.name > 0 ? modelData.name * 50 - 50 : 0

    //         TextStyledH {
    //             anchors.centerIn: parent
    //             text: "X"
    //         }

    //         MouseFill {
    //             onClicked: workspaceActivate(index + 1)
    //         }

    //         Component.onCompleted: {
    //             wsLast = parseInt(modelData.name)
    //         }
    //     }
    // }

    Behavior on width { NumberAnim {} }
}

// Item {
//     id: root
//     height: parent.height; width: 400
    
//     // Налаштування
//     property int workspacesShown: 5
//     property int workspaceButtonWidth: 35
//     property list<bool> workspaceOccupied: []

//     // 1. ЛОГІКА: Перевірка, чи є вікна на воркспейсі
//     function updateOccupied() {
//         workspaceOccupied = Array.from({ length: workspacesShown }, (_, i) => {
//             // Перевіряємо, чи існує воркспейс з таким ID у списку Hyprland
//             return Hyprland.workspaces.values.some(ws => ws.id === (i + 1));
//         })
//     }

//     // Оновлюємо список при старті та при змінах у Hyprland
//     Component.onCompleted: updateOccupied()
    
//     Connections {
//         target: Hyprland.workspaces
//         function onValuesChanged() { updateOccupied() }
//     }

//     // 2. ВЕРСТКА: Контейнер для кнопок
//     Row {
//         spacing: 5
//         anchors.centerIn: parent

//         Repeater {
//             model: root.workspacesShown

//             Button {
//                 id: wsButton
//                 property int wsId: index + 1
//                 property bool isFocused: Hyprland.focusedWorkspace.id === wsId
//                 property bool isOccupied: workspaceOccupied[index]

//                 implicitWidth: root.workspaceButtonWidth
//                 implicitHeight: root.workspaceButtonWidth

//                 // Клік перемикає воркспейс
//                 onClicked: Hyprland.dispatch(`workspace ${wsId}`)

//                 // Візуальна частина кнопки
//                 background: Rectangle {
//                     radius: width / 2
                    
//                     // Колір залежить від стану:
//                     // Активний -> Синій, Зайнятий -> Сірий, Порожній -> Прозорий
//                     color: wsButton.isFocused ? "#3584e4" : 
//                            (wsButton.isOccupied ? "#555555" : "transparent")
                    
//                     border.color: wsButton.isFocused ? "#3584e4" : "#444444"
//                     border.width: 1

//                     Behavior on color { ColorAnimation { duration: 200 } }
//                 }

//                 contentItem: Text {
//                     text: wsButton.wsId
//                     color: wsButton.isFocused ? "white" : "#bbbbbb"
//                     horizontalAlignment: Text.AlignHCenter
//                     verticalAlignment: Text.AlignVCenter
//                     font.pixelSize: 12
//                 }
//             }
//         }
//     }

//     // 3. ВЗАЄМОДІЯ: Скрол мишкою для перемикання
//     WheelHandler {
//         onWheel: (event) => {
//             if (event.angleDelta.y < 0) Hyprland.dispatch("workspace e+1")
//             else if (event.angleDelta.y > 0) Hyprland.dispatch("workspace e-1")
//         }
//     }
// }