pragma Singleton
import Quickshell
import Quickshell.Io
import qs.services

Singleton {
    property url dirSystemConfig: "/home/linco02/Atheris"
    property string systemVersion: ""
    property string systemDateUpdate: ""

    property url ditShellConfig: "/home/linco02/Atheris-shell"
    property string shellVersion: ""
    property string shellDateUpdate: ""

    property string globalVersion: {
        if (systemVersion >= shellVersion) return systemVersion
        return shellVersion
    }

    function updateShell() {shellUpdate.running = true}

    function updateInformation() {
        getUpdateDateSystem.running = true
        getUpdateDateShell.running = true
        getVersionSystem.running = true
    }

    Process {
        id: shellUpdate
        workingDirectory: ditShellConfig
        command: ["git pull"]
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

    Process {
        id: getUpdateDateSystem
        running: true
        workingDirectory: dirSystemConfig
        command: ["git", "log", "-1", "--format=%cd", "--date=short"]

        stdout: StdioCollector {
            onStreamFinished: {
                systemDateUpdate = this.text.trim()
            }
        }
    }

    Process {
        id: getUpdateDateShell
        running: true
        workingDirectory: ditShellConfig
        command: ["git", "log", "-1", "--format=%cd", "--date=short"]

        stdout: StdioCollector {
            onStreamFinished: {
                shellDateUpdate = this.text.trim()
            }
        }
    }

    Process {
        id: getVersionSystem
        running: true
        workingDirectory: dirSystemConfig
        command: ["git", "rev-parse", "--short", "HEAD"]

        stdout: StdioCollector {
            onStreamFinished: {
                systemVersion = this.text.trim()
            }
        }
    }

    Process {
        id: getVersionShell
        running: true
        workingDirectory: ditShellConfig
        command: ["git", "rev-parse", "--short", "HEAD"]

        stdout: StdioCollector {
            onStreamFinished: {
                shellVersion = this.text.trim()
            }
        }
    }
}