pragma Singleton
import Quickshell
import Quickshell.Io
import qs.config
// import qs.services

Singleton {
    property var actions: [
        { label: "Вимкнути", icon: "", command: ["systemctl", "poweroff"] },
        { label: "Перезавантажити", icon: "", command: ["systemctl", "reboot"] },
        { label: "Гібернація", icon: "󰚭", command: ["systemctl", "hibernate"] },
        { label: "Сон", icon: "󰤄", command: ["systemctl", "suspend"] },
        { label: "Заблокувати", icon: "", command: null }
    ]

    function choseAction(action) {
        if (action.command) {
            actionProcess.command = action.command
            actionProcess.running = true
        } else {
            Global.isSessionLock = true
        }
    }

    Process {
        id: actionProcess
        command: []
    }
}

// pragma Singleton
// import Quickshell
// import qs.config

// Singleton {
//     id: root
//     property bool isLock: Settings.enableLockStartUp
//     signal lock()
    
//     function sessionLock(locked) {
//         isLock = locked
//         lock()
//     }
// }