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

            Behavior on width { NumberAnim { duration: Appearance.durations.fast } }
        }
    }

    handle: Rect {
        y: root.topPadding + root.availableHeight / 2 - height / 2
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        implicitHeight: 20; implicitWidth: 6
        radius: implicitHeight / 2
        color: Colors.warning

        Behavior on x { NumberAnim { duration: Appearance.durations.fast } }
    }
}