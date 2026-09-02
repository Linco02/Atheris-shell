pragma Singleton
import Quickshell
import Quickshell.Io
import qs.services

Singleton {
    function updateShell() {shellUpdate.running = true}

    Process {
        id: shellUpdate
        command: ["sh", "-c", "git -C ~/Atheris-shell pull"]
        onExited: (exitCode, exitStatus) => {
            if (exitCode === 0) {
                SNotification.nitifiSend(
                    "Update",
                    STranslations.tr("update_success"),
                    "",
                    "software-installed-symbolic",
                    "normal",
                    5000,
                    0
                )
            } else {
                SNotification.nitifiSend(
                    "Update",
                    STranslations.tr("update_error"),
                    exitCode,
                    "software-update-urgent-symbolic",
                    "critical",
                    5000,
                    0
                )
            }
            console.log("Update", exitCode)
        }
    }
}