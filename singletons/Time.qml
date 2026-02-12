pragma Singleton
import QtQuick
import qs.singletons
import qs.settings
import qs.components

QtObject {
    signal date(string time)

    function clockUpdate() {
        const data = new Date().toLocaleTimeString("h:mm:ss")
        date(data)
    }

    property var connections: Connections {
        target: Timer30s
        function onTick() { 
            clockUpdate()
        }
    }
}