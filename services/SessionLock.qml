pragma Singleton
import Quickshell
import qs.config

Singleton {
    id: root
    property bool isLock: Settings.enableLockStartUp
    signal lock()
    
    function sessionLock(locked) {
        isLock = locked
        lock()
    }
}