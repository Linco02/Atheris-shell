pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    property bool isExist: false
    property int currentBrigtness: 0

    function brightnessSet(value) {
        const val = value + "%"
        brightnessSetting.command = [
            "sh", "-c",
            `brightnessctl set ${val}`
        ]
        brightnessSetting.running = true
        currentBrigtness = value
    }

    Process { id: brightnessSetting }

    Process {
        id: brightnessCheck
        running: true
        command: [
            "sh", "-c", "brightnessctl -q"
        ]
        
        stdout: StdioCollector {
            onStreamFinished: {
                if (this.text === "") return 
                
                isExist = true
                currentBrigtness = this.text.split("\n")
                    .map(b => b.trim())
                    .find(b => b.startsWith("Current brightness"))
                    .split("(")[1]
                    .replace("%)", "")
            }
        }
    }
}