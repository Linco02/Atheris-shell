pragma Singleton
import QtQuick

QtObject {
    id: root

    signal tick()

    property Timer timer: Timer {
        interval: 3000; running: true; repeat: true
        onTriggered: { root.tick() }
    }

    property Timer start: Timer {
        interval: 0; running: true
        onTriggered: { root.tick() }
    }
}