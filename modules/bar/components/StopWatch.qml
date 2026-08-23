// import QtQuick
import qs.components
import qs.components.shapes
import qs.config
import qs.services

RectForeground {
    height: parent.height
    width: timer.width + Style.padding.large
    
    TextStyledH {
        id: timer
        anchors.centerIn: parent
        text: " " + STime.stopWatchTime + " "
    }
}