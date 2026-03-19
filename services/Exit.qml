pragma Singleton
import Quickshell
import Quickshell.Io
import qs.config
import qs.services

Singleton {
    property var iconList: ({
        "Вимкнути" : "",
        "Перезавантажити" : "",
        "Сон" : "󰤄",
        "Гібернація" : "󰚭",
        "Заблокувати" : ""
    })

    Process { id: poweroffProcess; command: ["systemctl", "poweroff"] }
    Process { id: rebootProcess; command: ["systemctl", "reboot"] }
    Process { id: suspendProcess; command: ["systemctl", "suspend"] }
    Process { id: hibernateProcess; command: ["systemctl", "hibernate"] }

    function choseProcess(chose) {
        if (chose === "Вимкнути")
            poweroffProcess.running = true
        else if (chose === "Перезавантажити")
            rebootProcess.running = true
        else if (chose === "Сон")
            suspendProcess.running = true
        else if (chose === "Гібернація")
            hibernateProcess.running = true
        else if (chose === "Заблокувати")
            GlobalStates.isSessionLockLock = true
    }
}