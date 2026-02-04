pragma Singleton
import QtQuick

QtObject {
    id: root

    signal tick()

    property Timer timer: Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: { root.tick() }
    }
}
