import QtQuick
import QtQuick.Shapes
import Quickshell
import qs.components.shapes
import qs.components.animations
import qs.config

PopupWindow {
    id: root
    anchor {
        window: panel
        rect.x: panel.width / 2 - width / 2
        rect.y: panel.height
    }
    implicitHeight: 1000; implicitWidth: 2000
    color: "transparent"

    default property alias contents: container.data
    property alias containerH: container.height
    property alias containerW: container.width
    property bool isOpen: false
    property real percent: 1
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
        id: corners
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        height: rad
        width: back.width + rad * 2

        Corner {
            isLeft: true; anchors.left: parent.left
        }

        Corner {
            isLeft: false; anchors.right: parent.right
        }
    }

    Item {
        id: box
        anchors.horizontalCenter: parent.horizontalCenter
        y: 0
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
            height: container.height + Global.padding.normal
            width: container.width + Global.padding.large
            topLeftRadius: 0; topRightRadius: 0
        }

        RectClip {
            id: container
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
        }

        states: [
            State {
                name: "close"
                PropertyChanges { target: box; y: - box.height }
                PropertyChanges { target: root; percent: 0 }
            },
            State {
                name: "open"
                PropertyChanges { target: box; y: 0 }
                PropertyChanges { target: root; percent: 1 }
            }
        ]

        transitions: [
            Transition {
                from: "open"; to: "close"
                SequentialAnimation {
                    ParallelAnimation {
                        NumberAnim { property: "y" }
                        NumberAnim { property: "percent" }
                    }
                    PropertyAction {
                        target: root
                        property: "visible"
                        value: false
                    }
                    ScriptAction { script: closedPop() }
                }
            },
            Transition {
                from: "close"; to: "open"
                ParallelAnimation {
                    NumberAnim { property: "y" }
                    NumberAnim { property: "percent" }
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

    component Corner: Shape {
        height: rad; width: rad
        anchors.top: parent.top
        layer {
            enabled: true
            samples: 4
        }
        opacity: Global.appearance.opacity

        property bool isLeft: false

        ShapePath {
            strokeWidth: 0
            fillColor: Colors.surface
            startY: 0; startX: isLeft ? rad : 0
            PathLine { y: rad * percent; x: isLeft ? rad : 0 }
            PathArc {
                y: 0; x: isLeft ? 0 : rad 
                radiusY: rad; radiusX: rad
                direction: isLeft ? PathArc.Counterclockwise : PathArc.Clockwise
                useLargeArc: false
            }
            PathLine { y: 0; x: isLeft ? 0 : rad }
        }
    }
}