// import QtQuick
import qs.components
import qs.components.shapes
import qs.config
import qs.services

RectForeground {
    width: timer.width + Theme.padding.large
    
    TextStyledH {
        id: timer
        anchors.centerIn: parent
        text: " " + STime.stopWatchTime + " "
    }
}