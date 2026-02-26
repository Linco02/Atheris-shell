import QtQuick
import QtQuick.Shapes
import Quickshell
import qs.config
import qs.components.animations
import qs.components

PopupWindow {
    id: shapeJump
    visible: false
    color: "transparent"

    property alias containerHeight: container.height
    property alias containerWidth: container.width
    default property alias contents: container.data

    property real percent: 0
    property int rad: Appearance.radius.large

    function openMenu() {
        if (shapeJump.visible) {
            stateManager.state = "close"
        } else {
            visible = true
            stateManager.state = "open"
        }
    }

    Timer {
        id: time
        interval: 100
        onTriggered: {
            percent = 0
            stateManager.state = "close"
        }
    }

    Item {
        id: stateManager
        state: "close"

        states: [
            State {
                name: "close"
                PropertyChanges {
                    target: box
                    y: - box.height
                }
                PropertyChanges { target: shapeJump; percent: 0 }
            },
            State {
                name: "open"
                PropertyChanges {
                    target: box
                    y: 0
                }
                PropertyChanges { target: shapeJump; percent: 1 }
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
                        target: shapeJump
                        property: "visible"
                        value: false
                    }
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

    Item {
        id: box
        anchors {
            horizontalCenter: (rotate === 0 || rotate === 180) ? parent.horizontalCenter : undefined
            verticalCenter: (rotate === 90 || rotate === 270) ? parent.verticalCenter : undefined
            // leftMargin: (rotate === 90 || rotate === 270) ? (height - width) / 2 : 0
            // rightMargin: (rotate === 90 || rotate === 270) ? (height - width) / 2 : 0
        }
        height: ( rotate === 0 || rotate === 180 ) ?
            container.height + Appearance.padding.normal :
            container.width + Appearance.padding.normal
        width: ( rotate === 0 || rotate === 180) ?
            container.width + Appearance.padding.large :
            container.height + Appearance.padding.large
        rotation: rotate

        HoverHandler {
            onHoveredChanged: {
                if (!hovered) {
                    time.start()
                } else {
                    time.stop()
                }
            }
        }

        Shape {
            layer {
                enabled: true
                samples: 4
            }

            ShapePath {
                strokeWidth: 0
                fillColor: Appearance.surface
                startY: rad; startX: 0

                PathArc {
                    y: 0; x: rad
                    radiusY: rad; radiusX: rad
                }
                PathLine { y: 0; x: box.width - rad }
                PathArc {
                    y: rad; x: box.width
                    radiusY: rad; radiusX: rad
                }
                PathLine { y: box.height; x: box.width }
                PathLine { y: box.height; x: 0 }
            }
        }

        Item {
            id: container
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            rotation: 
                rotate === 90 ? 270 :
                rotate === 270 ? 90 :
                rotate === 180 ? 180 :
                0
        }
    }

    Item {
        id: corners
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        height: rad
        width: box.width + rad * 2
        rotation: rotate
        y: 200

        Shape {
            id: leftCorner
            height: rad; width: rad
            anchors {
                left: parent.left
                bottom: parent.bottom
            }
            layer {
                enabled: true
                samples: 4
            }

            ShapePath {
                strokeWidth: 0
                fillColor: Appearance.surface
                startY: rad; startX: 0
                PathArc {
                    y: rad - rad * percent; x: rad
                    radiusY: rad; radiusX: rad;
                    direction: PathArc.Counterclockwise
                    useLargeArc: false
                }
                PathLine { y: rad; x: rad; }
                PathLine { y: rad; x: 0 }
            }
        }

        Shape {
            height: rad; width: rad
            anchors {
                right: parent.right
                bottom: parent.bottom
            }
            layer {
                enabled: true
                samples: 4
            }

            ShapePath {
                strokeWidth: 0
                fillColor: Appearance.surface
                startY: rad; startX: rad
                PathArc {
                    y: rad - rad * percent; x: 0 
                    radiusY: rad; radiusX: rad
                    useLargeArc: false
                }
                PathLine { y: rad; x: 0 }
                PathLine { y: rad; x: rad }
            }
        }
    }
}