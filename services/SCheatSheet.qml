pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    property var bindList: []

    Process {
        running: true
        command: [
            "sh", "-c",
            "cat ~/.config/hypr/hyprland.conf"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let response = this.text

                let result = response
                    .split("\n")
                    .map(line => line.trim())
                    .filter(line => line.startsWith("bind"))
                    .map(line => line.split(",").map(part => part.trim()))
                    .map(res => ({
                        "mod": res[0] ? res[0].replace(/^bind[a-z]*\s*=\s*/, "") : "",
                        "key": res[1] || "",
                        "dispatcher": res[2] || "",
                        "arg": res[3] || ""
                    }))

                bindList = result
            }
        }
    }
}