import QtQuick
import QtQuick.Controls
import qs.config
import qs.components.animations
import qs.components.containers
import qs.components.shapes
import qs.components

Rectangle {
    id: root
    // anchors.centerIn: parent
    height: 200; width: 200
    property bool is: true

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            if (is) {
                root.height = 200
                root.width = 200
            } else {
                root.height = 400
                root.width = 400
            }
            is = !is
        }
    }
}