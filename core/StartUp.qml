pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    property bool isWallaperThumbnailCreate: false

    Process {
        id: makeDir
        running: true
        command: [
            "mkdir", "-p", "/tmp/atheris/wallpaperThumbnail"
        ]
        onExited: (exitCode, exitStatus) => {
            if (exitCode === 0) {
                isWallaperThumbnailCreate = true
            } else {
                console.warn("StartUp: Failed to create temporary directories with exit code:", exitCode)
            }
        }
    }
}