import QtQuick
import qs.singletons
import qs.settings
import qs.components

RectForeground {
    height: panelHeight - Style.padding2x; width: clockText.width + Style.padding * 2

    property string time: ""

    Connections {
        target: Time
        function onDate(data) {
            time = data
        }
    }

    TextStyle2 {
        id: clockText
        anchors.centerIn: parent
        text: time
    }
}