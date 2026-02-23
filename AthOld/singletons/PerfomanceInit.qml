pragma Singleton
import QtQuick
import Quickshell.Io

Item {
    property string gpuType: "unknown"
    property string cpuType: "unknown"

    readonly property QtObject gpu: QtObject {
        property real percent: 0
        property string textInd1: ""
        property string textInd2: ""
    }

    readonly property QtObject cpu: QtObject {
        property real percent: 0
        property string textInd1: ""
        property string textInd2: ""
    }

    readonly property QtObject mem: QtObject {
        property real percent: 0
        property string textInd1: ""
        property string textInd2: ""
    }

    Connections {
        target: Timer3s
        function onTick() {
            gpuPerfomance.running = true
            cpuPerfomance.running = true
            memPerfomance.running = true
        } 
    }

    Process {
        id: gpuPerfomance
        command: {
            if (gpuType === "amd") {
                return ["true"]
            } else if (gpuType === "nvidia") {
                return [
                    "sh", "-c",
                    "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits"
                ]
            } else if (gpuType === "intel") {
                return ["true"]
            } else {
                return ["true"]
            }
        }

        stdout: StdioCollector {
            onStreamFinished: {
                if (gpuType === "amd") {
                    var indicator1 = 0
                    var indicator2 = 0

                    gpu.textInd1 = indicator1 + "%"
                    gpu.textInd2 = indicator2 + "°C"
                    gpu.percent = indicator1 / 100
                } else if (gpuType === "nvidia") {
                    var info = this.text.trim().split(",")
                    var indicator1 = parseInt(info[0])
                    var indicator2 = parseInt(info[1])

                    gpu.textInd1 = indicator1 + "%"
                    gpu.textInd2 = indicator2 + "°C"
                    gpu.percent = indicator1 / 100
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
                const indicator2 = (parseInt(info[2]) / 1000).toFixed(0)
                var percent = (1 - (idle2 - cpuPerfomance.idle1) / (total2 - cpuPerfomance.total1)).toFixed(2)

                cpu.percent = percent
                cpu.textInd1 = (percent * 100).toFixed(0) + "%"
                cpu.textInd2 = indicator2 + "°C"

                cpuPerfomance.total1 = total2
                cpuPerfomance.idle1 = idle2
            }
        }
    }

    Process {
        id: memPerfomance
        command: [
            "sh", "-c",
            "awk 'NR<=3 && NR!=2 {print $2}' /proc/meminfo"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                var info = this.text.split("\n")
                var indicator1 = parseInt(info[0]) / 1024
                var indicator2 = parseInt(info[1]) / 1024

                mem.textInd1 = ((indicator1 - indicator2) / 1000).toFixed(2) + "Гб"
                mem.textInd2 = ((indicator2) / 1000).toFixed(2) + "Гб"
                mem.percent = (1 - (indicator2 * 100 / indicator1) / 100).toFixed(2)
            }        
        }
    }

    Component.onCompleted: {
        gpuInit.running = true
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
            }
        }
    }
}