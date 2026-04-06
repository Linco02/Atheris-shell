pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property string gpuType: ""
    property string cpuType: ""
    property var cpu: [0, 0, 0]
    property var gpu: [0, 0, 0]
    property var mem: [0, 0, 0]

    function runPerfomance() {
        gpuPerfomance.running = true
        cpuPerfomance.running = true
        memPerfomance.running = true
    }

    Process {
        id: gpuPerfomance
        command: {
            if (gpuType === "amd") {
                return [
                    "sh", "-c",
                    "cat /sys/class/drm/card1/device/gpu_busy_percent" +
                    "&&" +
                    "awk 'NR == 1 { idle = $5 + $6; total = 0; for (i=2; i<=9; i++) total += $i; print idle, total}' /proc/stat && cat $(grep -rl 'coretemp\\|k10temp' /sys/class/hwmon/hwmon*/name | head -1 | xargs dirname)/temp1_input"
                ]
            } else if (gpuType === "nvidia") {
                return [
                    "sh", "-c",
                    "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits"
                ]
            } else if (gpuType === "intel") {
                return ["true"]
            } else return ["true"]
        }

        stdout: StdioCollector {
            onStreamFinished: {
                if (gpuType === "amd") {
                    var info = this.text.trim().split("\n")
                    if (info.length >= 2) {
                        var load = parseInt(info[0])
                        var temp = (parseInt(info[1]) / 1000).toFixed(0)
                        let percent = load / 100

                        gpu = [percent, load, temp]
                    }
                } else if (gpuType === "nvidia") {
                    var info = this.text.trim().split(",")
                    var load = parseInt(info[0])
                    var temp = parseInt(info[1])
                    let percent = load / 100

                    gpu = [percent, load, temp]
                }
            }        
        }
    }

    Process {
        id: cpuPerfomance
        command: [
            "sh", "-c",
            "awk 'NR == 1 { idle = $5 + $6; total = 0; for (i=2; i<=9; i++) total += $i; print idle, total}' /proc/stat && cat /sys/class/hwmon/hwmon3/temp1_input"
        ]

        property int total1: 0
        property int idle1: 0

        stdout: StdioCollector {
            onStreamFinished: {
                var info = this.text.trim().split(/\s+/)
                const idle2 = parseInt(info[0])
                const total2 = parseInt(info[1])
                const temp = (parseInt(info[2]) / 1000).toFixed(0)
                let percent = (1 - (idle2 - cpuPerfomance.idle1) / (total2 - cpuPerfomance.total1)).toFixed(2)
                let load = (percent * 100).toFixed(0)

                cpu = [percent, load, temp]

                cpuPerfomance.total1 = total2
                cpuPerfomance.idle1 = idle2
            }
        }
    }

    Process {
        id: memPerfomance
        command: [
            "sh", "-c",
            "awk '/MemTotal|MemAvailable/ {print $2}' /proc/meminfo"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                var info = this.text.split("\n")
                var indicator1 = parseInt(info[0]) / 1024
                var indicator2 = parseInt(info[1]) / 1024
                let percent = (1 - (indicator2 * 100 / indicator1) / 100).toFixed(2)
                let load = ((indicator1 - indicator2) / 1000).toFixed(2)
                let free = ((indicator2) / 1000).toFixed(2)

                mem = [percent, load, free]
            }        
        }
    }

    Process {
        id: gpuInit
        command: ["sh", "-c", "lspci | grep -iE 'vga|3d'"]
        
        stdout: StdioCollector {
            onStreamFinished: {
                const gpuInfo = this.text.toLowerCase()
                if (gpuInfo.includes("nvidia")) gpuType = "nvidia"
                else if (gpuInfo.includes("amd") || gpuInfo.includes("ati")) gpuType = "amd"
                else if (gpuInfo.includes("intel")) gpuType = "intel"

                runPerfomance()          
            }
        }
    }

    Connections {
        target: Tick3s
        function onTick() { runPerfomance() }
    }

    Component.onCompleted: {
        if (!gpuType) gpuInit.running = true
        else runPerfomance()
    }
}