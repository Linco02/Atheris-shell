import QtQuick
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.config
import qs.services

RectForeground {
    id: root
    height: !isHorizontal ? clockContainer.height + Theme.padding.normal * 2: Theme.barWidth
    width: isHorizontal ? clockContainer.width + Theme.padding.normal * 2 : Theme.barWidth

    property bool isHorizontal: true

    GridRotable {
        id: clockContainer
        anchors.centerIn: parent
        count: 3
        isHorizontal: root.isHorizontal

        TextClock {
            id: clock
            text: STime.hour
        }

        TextClock {
            visible: isHorizontal
            text: ":"
        }

        TextClock {
            text: STime.minute
        }
    }

    component TextClock: TextStyled {
        // height: !isHorizontal ? Theme.barWidth : width
        // width: isHorizontal ? Theme.barWidth : height
        fontSize: Theme.barWidth - Theme.padding.small * 2
    }

    TapHandler {onTapped: {SWManager.controlAtherisCenter("dashboard", "dash")}}
}