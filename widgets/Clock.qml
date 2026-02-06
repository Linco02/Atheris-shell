import QtQuick
import qs.settings
import qs.component

Item {
    property var date: ""

    height: 20; width: clockText.width + Style.padding * 2

    Connections {
        target: SingleTimer1
        function onTick() { 
            date = new Date().toLocaleTimeString("h:mm:ss")
        }
    }

    RectForeground {
        anchors.centerIn: parent
        height: parent.height - Style.padding; width: parent.width
        TextStyle1 {
            id: clockText
            anchors.centerIn: parent
            font.pointSize: parent.height - Style.padding * 2
            text: date
        }
    }
}