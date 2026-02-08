import QtQuick
import qs.singletons
import qs.settings
import qs.components

Item {
    property var date: ""
    property var time: ""

    height: isVerticalPanel ? clockText.height + Style.padding * 2 : panelHeight 
    width: isVerticalPanel ? panelWidth : clockText.width + Style.padding * 2

    Connections {
        target: SingleTimer1
        function onTick() { 
            time = new Date().toLocaleTimeString("h:mm:ss")
            if (isVerticalPanel === true) {
                date = time.replace(/:/g, "\n")
            } else
            date = time
        }
    }

    RectForeground {
        anchors.centerIn: parent
        radius: 0
        height: isVerticalPanel ? clockText.height : parent.height
        width: isVerticalPanel ? parent.width : parent.width - Style.padding
        TextStyle1 {
            id: clockText
            anchors.centerIn: parent
            font.pointSize: isVerticalPanel ? parent.width - Style.padding * 3 : parent.height - Style.padding * 2
            text: date
            wrapMode: Text.Wrap
        }
    }
}