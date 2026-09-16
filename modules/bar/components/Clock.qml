import QtQuick
import qs.components
import qs.components.shapes
import qs.config
import qs.services

RectForeground {
    height: parent.height
    width: clock.width + Theme.padding.large
    
    TextStyledH {
        id: clock
        anchors.centerIn: parent
        text: STime.time
    }

    TapHandler {onTapped: {SWManager.controlAtherisCenter("dashboard", "dash")}}
}