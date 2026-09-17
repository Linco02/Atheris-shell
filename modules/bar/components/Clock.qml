import QtQuick
import qs.components
import qs.components.shapes
import qs.config
import qs.services

RectForeground {
    width: clock.width + Theme.padding.normal + (!Theme.theme.useAngledShapes ? Theme.padding.normal : 0)
    
    TextStyledH {
        id: clock
        anchors.centerIn: parent
        text: STime.time
    }

    TapHandler {onTapped: {SWManager.controlAtherisCenter("dashboard", "dash")}}
}