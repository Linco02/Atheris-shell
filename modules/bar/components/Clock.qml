import QtQuick
import qs.services
import qs.config
import qs.components.shapes
import qs.components.animations
import qs.components

RectForeground {
    height: root.height - Appearance.padding.normal; width: clockText.width + Appearance.padding.large
    
    property string time: ""

    Connections {
        target: Time
        function onTime(data) {
            time = data
        }
    }

    TextStyledH {
        id: clockText
        anchors.centerIn: parent
        text: time
    }
}