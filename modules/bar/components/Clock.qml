import QtQuick
import qs.components
import qs.components.shapes
import qs.config
import qs.services

RectForeground {
    height: root.height - Global.padding.normal
    width: clock.width + Global.padding.large
    
    TextStyledH {
        id: clock
        anchors.centerIn: parent
        text: TimeServices.time
    }
}