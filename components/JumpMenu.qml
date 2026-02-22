import QtQuick
import QtQuick.Shapes
import Quickshell
import qs.components
import qs.settings

PopupWindow {
    id: jumpMenuComponents
    anchor {
        window: root
        rect.x: root.width / 2 - width / 2
        rect.y: isTop ? root.height : - root.height - height
    }
    implicitHeight: box.height
    implicitWidth: box.width + radius2 * 2

    
    visible: false
    color: "transparent"

    default property alias contents: inerBox.data
    property alias containerHeight: inerBox.height
    property alias containerWidth: inerBox.width

    property bool isTop: root.isTop
    property int rotate: isTop ? 180 : 0

    property real radius: Style.radius
    property real radius2: Style.radius2
    property real percent: 0


    function openMenu() {
        if (jumpMenuComponents.visible) {
            stateManager.state = "closed"
        } else {
            visible = true
            stateManager.state = "open"
        }
    }

    Item {
        id: stateManager
        states: [
            State {
                name: "closed"
                PropertyChanges { target: box; y: -box.height }
                PropertyChanges { target: jumpMenuComponents; percent: 0 }
            },
            State {
                name: "open"
                PropertyChanges { target: box; y: 0 }
                PropertyChanges { target: jumpMenuComponents; percent: 1 }
            }
        ]
        
        state: "closed"

        transitions: [
            Transition {
                from: "open"; to: "closed"
                SequentialAnimation {
                    ParallelAnimation {
                        DefaultNumAnim { property: "y" }
                        DefaultNumAnim { property: "percent" }
                    }

                    PropertyAction {
                        target: jumpMenuComponents
                        property: "visible"
                        value: false
                    }
                }
            },

            Transition {
                from: "closed"; to: "open"
                ParallelAnimation {
                    DefaultNumAnim { property: "y" }
                    DefaultNumAnim { property: "percent" }
                }
            }
        ]
    }

    Timer {
        id: time
        interval: 100
        onTriggered: {
            percent = 0
            stateManager.state = "closed"
        }
    }

    Item {
        id: box
        anchors.horizontalCenter: parent.horizontalCenter
        height: inerBox.height; width: inerBox.width

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
            rotation: rotate

            ShapePath {
                strokeWidth: 0
                fillColor: Style.backGround
                startY: radius2; startX: 0
                PathArc {
                    y: 0; x: radius2
                    radiusY: radius2; radiusX: radius2
                }
                PathLine { y: 0; x: width - radius2 * 3}
                PathArc {
                    y: radius2; x: width - radius2 * 2
                    radiusY: radius2; radiusX: radius2
                }
                PathLine { y: height; x: width - radius2 * 2 }
                PathLine { y: height; x: 0 }
            }
        }

        Item {
            id: inerBox
        }
    }

    Shape {
        height: radius2; width: radius2
        anchors {
            right: isTop ? undefined : box.left
            left: isTop ? box.right : undefined
            bottom: isTop ? undefined : jumpMenuComponents.bottom
            top: isTop ? jumpMenuComponents.top : undefined
        }
        layer {
            enabled: true
            samples: 4
        }
        rotation: rotate

        ShapePath {
            strokeWidth: 0
            fillColor: Style.backGround
            startY: radius2; startX: 0
            PathArc {
                y: radius2 - radius2 * percent; x: radius2
                radiusY: radius2; radiusX: radius2;
                direction: PathArc.Counterclockwise
                useLargeArc: false
            }
            PathLine { y: radius2; x: radius2; }
            PathLine { y: radius2; x: 0 }
        }
    }

    Shape {
        height: radius2; width: radius2
        anchors {
            right: isTop ? box.left : undefined
            left: isTop ? undefined : box.right
            bottom: root.isTop ? undefined : jumpMenuComponents.bottom
            top: root.isTop ? jumpMenuComponents.top : undefined
        }
        layer {
            enabled: true
            samples: 4
        }
        rotation: rotate

        ShapePath {
            strokeWidth: 0
            fillColor: Style.backGround
            startY: radius2; startX: radius2
            PathArc {
                y: radius2 - radius2 * percent; x: 0 
                radiusY: radius2; radiusX: radius2
                useLargeArc: false
            }
            PathLine { y: radius2; x: 0 }
            PathLine { y: radius2; x: radius2 }
        }
    }
}