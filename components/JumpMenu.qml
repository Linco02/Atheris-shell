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
    visible: false
    color: "transparent"

    signal close()
    signal open()

    property bool isTop: root.isTop
    property int rotate: isTop ? 180 : 0
    property real radius: Style.radius
    property real radius2: Style.radius2
    property real percent: 0

    Behavior on percent {
        NumberAnimation {
            duration: 400
            easing.type: Easing.InOutQuad
        }
    }

    onPercentChanged: {
        if (percent === 0 && jumpMenuComponents.visible) {
            jumpMenuComponents.visible = false
        } else if(percent === 1) {
            open()
        }
    }

    Timer {
        id: time
        interval: 100
        onTriggered: {
            jumpMenuComponents.percent = 0
            close()
        }
    }

    Shape {
        id: box
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: isTop ? undefined : parent.bottom
            top: isTop ? parent.top : undefined
        }
        height: parent.height * percent; width: parent.width - radius2 * 2
        rotation: rotate

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                jumpMenuComponents.visible = true
                jumpMenuComponents.percent = 1
                time.stop()
            }
            onExited: {
                time.running = true
            }
        }

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

    Shape {
        height: radius2; width: radius2
        anchors {
            right: isTop ? undefined : box.left
            left: isTop ? box.right : undefined
            bottom: isTop ? undefined : box.bottom
            top: isTop ? box.top : undefined
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
            bottom: root.isTop ? undefined : box.bottom
            top: root.isTop ? box.top : undefined
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