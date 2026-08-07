pragma Singleton
import QtQuick
import Quickshell

Singleton {
    signal tick1s()
    signal tick3s()
    signal tick10s()
    signal tick30s()
    signal tick1m()

    property int _secondCount: 0

    Timer {
        interval: 1000; running: true; repeat: true; triggeredOnStart: true
        onTriggered: {
            _secondCount++

            tick1s()
            
            if (_secondCount % 3 === 0) tick3s()
            if (_secondCount % 10 === 0) tick10s()
            if (_secondCount % 30 === 0) tick30s()

            if (_secondCount % 60 === 0) {
                tick1m()
                _secondCount = 0
            }
        }
    }
}