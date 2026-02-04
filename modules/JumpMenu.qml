import QtQuick
import QtQuick.Shapes
import Quickshell
import qs.singles

PanelWindow {
    id: shell

    property real radius: Style.radius1
    property real radius2: Style.radius2
    property real percent: 0

    anchors {
        left: true
        bottom: true
        right: true
    }
    implicitHeight: 4
    color: Style.backGround

    Behavior on percent {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuad
        }
    }

    onPercentChanged: {
        if (percent === 0 && widget.visible) {
            widget.visible = false
        }
    }

    Timer {
        id: time
        interval: 100
        onTriggered: shell.percent = 0
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            widget.visible = true
            shell.percent = 1
            time.stop()
        }
        onExited: {
            time.running = true
        }
    }

    PopupWindow {
        id: widget
        anchor {
            window: shell
            rect.x: parentWindow.width / 2 - width / 2
            rect.y: - parentWindow.height + shell.height - height
        }
        implicitHeight: 150; implicitWidth: 400
        visible: false
        color: "transparent"
        Rectangle {
            id: box
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
            height: parent.height * percent; width: parent.width - 60
            color: Style.backGround
            topLeftRadius: radius1; topRightRadius: radius1

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    widget.visible = true
                    shell.percent = 1
                    time.stop()
                }
                onExited: {
                    time.running = true
                }
            }
        }

        Shape {
            height: radius2; width: radius2
            anchors {
                right: box.left
                bottom: box.bottom
            }
            ShapePath {
                strokeWidth: 0
                fillColor: Style.backGround
                startY: radius2; startX: 0
                PathArc {
                    x: radius2; y: radius2 - radius2 * percent
                    radiusX: radius2; radiusY: radius2
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
                left: box.right
                bottom: box.bottom
            }
            ShapePath {
                strokeWidth: 0
                fillColor: Style.backGround
                startY: radius2; startX: radius2
                PathArc {
                    x: 0; y: radius2 - radius2 * percent
                    radiusX: radius2; radiusY: radius2
                    useLargeArc: false
                }
                PathLine { y: radius2; x: 0 }
                PathLine { y: radius2; x: radius2 }
            }
        }
    }
}