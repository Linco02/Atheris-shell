import QtQuick
import QtQuick.Controls
import qs.components.shapes
import qs.components.animations
import qs.config

Slider {
    id: root

    background: RectInactive {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitHeight: 6
        implicitWidth: 200
        height: implicitHeight
        width: root.availableWidth

        RectActive {
            height: parent.height
            width: root.visualPosition * parent.width
        }
    }

    handle: RectWarning {
        y: root.topPadding + root.availableHeight / 2 - height / 2
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        height: 20; width: 6
    }

    Behavior on width { NumberAnim { } }
    Behavior on opacity { NumberAnim { } }
}