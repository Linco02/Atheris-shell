import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.animations
import qs.config

RectInactive {
    id: root
    width: height * 2
    color: hovered ? Qt.lighter(isActive ? Theme.colors.active : Theme.colors.inactive, Theme.hover)
        : isActive ? Theme.colors.active
        : Theme.colors.inactive

    property bool isActive: false
    property bool fillH: true
    property bool hovered: hover.hovered

    signal clicked()

    RectForeground {
        anchors {
            verticalCenter: parent.verticalCenter
        }
        height: parent.height - Theme.padding.normal; width: height
        x: {
            isActive ? parent.width - width - Theme.padding.normal / 2
            : Theme.padding.normal / 2
        }

        Behavior on x {NumberAnim{}}
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: clicked() }
}