pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    property bool isAirplaneOn: false

    function toggle() {
        isAirplaneOn = !isAirplaneOn

        airplaneToggle.command = isAirplaneOn
            ? ["rfkill", "block", "all"]
            : ["rfkill", "unblock", "all"]
        airplaneToggle.running = true
    }

    Process { id: airplaneToggle }
    
    Process {
        id: airplaneInit
        running: true
        command: ["rfkill", "list"]
        stdout: SplitParser {
            onRead: data => {
                if (data.includes("Soft blocked: yes")) {
                    isAirplaneOn = true
                } else if (data.includes("Soft blocked: no")) {
                    isAirplaneOn = false
                }
            }
        }
    }
}