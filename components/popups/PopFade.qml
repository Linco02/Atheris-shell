import QtQuick
import QtQuick.Shapes
import Quickshell
import qs.config
import qs.components.animations
import qs.components

PopupWindow {
    id: root
    visible: false
    color:  "transparent"

    property alias containerHeight: container.height
    property alias containerWidth: container.width
    default property alias contents: container.data

    function openMenu() {
        if (root.visible) {
            stateManager.state = "close"
        } else {
            visible = true
            stateManager.state = "open"
        }
    }

    mask: Region {
        y: container.y; x: container.x
        height: container.height; width: container.width
    }

    Timer {
        id: time
        interval: 100
        onTriggered: { openMenu() }
    }

    Item {
        id: stateManager
        state: "close"

        states: [
            State {
                name: "close"
                PropertyChanges {
                    target: container
                    x: - container.width
                }
            },
            State {
                name: "open"
                PropertyChanges {
                    target: container
                    x: 0
                }
            }
        ]

        transitions: [
            Transition {
                from: "open"; to: "close"
                SequentialAnimation {
                    ParallelAnimation {
                        NumberAnim { property: "x" }
                    }
                    PropertyAction {
                        target: root
                        property: "visible"
                        value: false
                    }
                }
            },
            Transition {
                from: "close"; to: "open"
                ParallelAnimation {
                    NumberAnim { property: "x" }
                }
            }
        ]
    }

    RectBackground {
        id: container
        height: 400; width: 200
        border.color: Colors.outline
        border.width: 2

        RectActive {
            height: 380; width: 200
        }
    }
}