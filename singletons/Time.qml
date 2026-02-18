pragma Singleton
import QtQuick
import qs.singletons
import qs.settings
import qs.components

QtObject {
    signal date(var date)
    signal time(var time)

    function clockUpdate() {
        let currentDate = new Date()
        const dataDate = Qt.formatDateTime(currentDate, "dd/MM/yyyy")
        const dateTime = Qt.formatTime(currentDate, "hh:mm")

        time(dateTime)
        date(dataDate)
    }

    property var connections: Connections {
        target: Timer30s
        function onTick() { 
            clockUpdate()
        }
    }
}