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
    property int positionX: Style.padding.normal
    property int rad: Style.radius.large
    property var panel: null
    property string position: ""
    property bool isHorizontalCenter: false
    property bool isVerticalCenter: false

    signal closedPop()

    onIsOpenChanged: {
        if (isOpen) {
            visible = true
            box.state = "open"
        } else {
            box.state = "close"
        }
    }

    RectBackground {
        id: box
        y: Style.padding.normal
        height: container.height + Style.padding.large
        width: container.width + Style.padding.large
        state: "close"
        anchors {
            left: position === "left" ? parent.left : undefined
            right: position === "right" ? parent.right : undefined
            top: position === "top" ? parent.top : undefined
            bottom: position === "bottom" ? parent.bottom : undefined
            horizontalCenter: isHorizontalCenter ? parent.horizontalCenter : undefined
            verticalCenter: isVerticalCenter ? parent.verticalCenter : undefined
        }

        HoverHandler {
            onHoveredChanged: {
                if(!hovered) timer.start()
                else {
                    box.state = "open"
                    timer.stop()
                }
            }
        }

        RectClip {
            id: container
            anchors.centerIn: parent

            Behavior on width {
                enabled: container.width > 0
                NumberAnim { }
            }
            Behavior on height {
                enabled: container.height > 0
                NumberAnim { }
            }
        }

        states: [
            State {
                name: "close"
                PropertyChanges { target: box; y: - box.height }
            },
            State {
                name: "open"
                PropertyChanges { target: box; y: Style.padding.normal }
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