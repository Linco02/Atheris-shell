pragma Singleton
import Quickshell
import Quickshell.Io
import qs.services

Singleton {
    function updateShell() {shellUpdate.running = true}

    Process {
        id: shellUpdate
        command: ["git", "-C", SystemUtils.homeDir + "/Atheris-shell", "pull"]
        onExited: (exitCode, exitStatus) => {
            if (exitCode === 0) {
                SNotification.nitifiSend("Update", "Оновлення успішне", "", "software-installed-symbolic", "normal", 5000, 0)
            } else {
                SNotification.nitifiSend("Update", "Помилка під час оновлення", exitCode, "software-update-urgent-symbolic", "critical", 5000, 0)
            }
        }
    }
}