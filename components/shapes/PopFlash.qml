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
        y: box.y; x: box.x
        height: box.height; width: box.width
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
                    target: box
                    opacity: 0
                }
            },
            State {
                name: "open"
                PropertyChanges {
                    target: box
                    opacity: 1
                }
            }
        ]

        transitions: [
            Transition {
                from: "open"; to: "close"
                SequentialAnimation {
                    ParallelAnimation {
                        NumberAnim { property: "opacity" }
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
                    NumberAnim { property: "opacity" }
                }
            }
        ]
    }

    RectBackground {
        id: box
        anchors {
            left: isLeft === true ? parent.left : undefined
            right: isLeft === false ? parent.right: undefined
        }
        height: container.height + Appearance.padding.large
        width: container.width + Appearance.padding.large
        border.color: Colors.outline
        border.width: 2

        Item {
            id: container
            anchors.centerIn: parent
            width: childrenRect.width
            height: childrenRect.height
        }
    }
}