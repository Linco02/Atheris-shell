import QtQuick
import Quickshell
import qs.components.shapes
import qs.components.animations
import qs.config

PopupWindow {
    id: root
    color: "transparent"
    anchor {
        window: panel
        rect.x: positionX
        rect.y: panel.height
    }
    implicitHeight: 1000; implicitWidth: 600
    
    default property alias contents: container.data
    property alias containerH: container.height
    property alias containerW: container.width
    property bool isOpen: false
    property int positionX: Global.padding.normal
    property int rad: Global.radius.large
    property var panel: null

    signal closedPop()

    onIsOpenChanged: {
        if (isOpen) {
            visible = true
            box.state = "open"
        } else {
            box.state = "close"
        }
    }

    Item {
        id: box
        y: Global.padding.normal
        height: back.height; width: back.width
        state: "close"

        HoverHandler {
            onHoveredChanged: {
                if(!hovered) timer.start()
                else {
                    box.state = "open"
                    timer.stop()
                }
            }
        }

        RectBackground {
            id: back
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            height: container.height + Global.padding.large
            width: container.width + Global.padding.large
        }

        RectClip {
            id: container
            anchors.centerIn: back

            Behavior on width { NumberAnim { } }
            Behavior on height { NumberAnim { } }
        }

        states: [
            State {
                name: "close"
                PropertyChanges { target: box; y: - box.height }
            },
            State {
                name: "open"
                PropertyChanges { target: box; y: Global.padding.normal }
            }
        ]

        transitions: [
            Transition {
                from: "open"; to: "close"
                SequentialAnimation {
                    ParallelAnimation {
                        NumberAnim { property: "y" }
                    }
                    ScriptAction {
                        script: {
                            closedPop()
                            root.visible = false
                        }
                    }
                }
            },
            Transition {
                from: "close"; to: "open"
                ParallelAnimation {
                    NumberAnim { property: "y" }
                }
            }
        ]
    }

    Timer {
        id: timer
        interval: 100
        onTriggered: box.state = "close"
    }

    mask: Region {
        x: box.x
        y: box.y
        width: box.width
        height: box.height
    }
}

// PopupWindow {
//     id: root
//     visible: false
//     color:  "transparent"

//     property alias containerHeight: container.height
//     property alias containerWidth: container.width
//     default property alias contents: container.data

//     function openMenu() {
//         if (root.visible) {
//             stateManager.state = "close"
//         } else {
//             visible = true
//             stateManager.state = "open"
//         }
//     }

//     mask: Region {
//         y: container.y; x: container.x
//         height: container.height; width: container.width
//     }

//     Timer {
//         id: time
//         interval: 100
//         onTriggered: { openMenu() }
//     }

//     Item {
//         id: stateManager
//         state: "close"

//         states: [
//             State {
//                 name: "close"
//                 PropertyChanges {
//                     target: container
//                     x: - container.width
//                 }
//             },
//             State {
//                 name: "open"
//                 PropertyChanges {
//                     target: container
//                     x: 0
//                 }
//             }
//         ]

//         transitions: [
//             Transition {
//                 from: "open"; to: "close"
//                 SequentialAnimation {
//                     ParallelAnimation {
//                         NumberAnim { property: "x" }
//                     }
//                     PropertyAction {
//                         target: root
//                         property: "visible"
//                         value: false
//                     }
//                 }
//             },
//             Transition {
//                 from: "close"; to: "open"
//                 ParallelAnimation {
//                     NumberAnim { property: "x" }
//                 }
//             }
//         ]
//     }

//     RectBackground {
//         id: container
//         height: 400; width: 200
//         border.color: Colors.outline
//         border.width: 2

//         RectActive {
//             height: 380; width: 200
//         }
//     }
// }