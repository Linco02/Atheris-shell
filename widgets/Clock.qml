import QtQuick
import qs.singletons
import qs.settings
import qs.components

RectBackground {
    height: 20; width: clockText.width + Style.padding * 2
    property string time: ""

    Connections {
        target: Time
        function onDate(data) {
            time = data
        }
    }

    Text {
        id: clockText
        anchors.centerIn: parent
        text: time
    }
}