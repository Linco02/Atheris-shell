import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.animations
import qs.config

RectForeground {
    id: root
    width: height * 2
    color: hovered ? Qt.lighter(Theme.surfaceRaised, Style.hover)
        : Theme.surfaceRaised

    property bool isActive: false
    property bool fillH: true
    property bool hovered: hover.hovered

    signal clicked()

    RectActive {
        anchors {
            verticalCenter: parent.verticalCenter
        }
        height: parent.height - Style.padding.normal; width: height
        x: {
            isActive ? parent.width - width - Style.padding.normal / 2
            : Style.padding.normal / 2
        }

        Behavior on x {NumberAnim{}}
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: clicked() }
}