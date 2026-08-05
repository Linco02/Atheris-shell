pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property var displays: []

    Process {
        id: getInfo
        running: true
        command: [
            "sh", "-c",
            "hyprctl monitors -j"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    displays = JSON.parse(this.text)
                } catch (e) {
                    console.error("Помилка парсингу JSON від hyprctl:", e)
                    displays = []
                }
            }
        }
    }
}