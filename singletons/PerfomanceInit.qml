pragma Singleton
import QtQuick
import Quickshell.Io

Item {
    Process {
        id: cpuPerfomance
        command: [
            "sh", "-c",
            "awk 'NR == 1 { idle = $5 + $6; total = 0; for (i=2; i<=9; i++) total += $i; print idle, total}' /proc/stat && cat /sys/class/hwmon/hwmon3/temp1_input"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                var info = this.text.trim().split(/\s+/)
                const idle2 = parseInt(info[0])
                const total2 = parseInt(info[1])
                indicator2 = parseInt(info[2]) / 1000

                percent = (1 - (idle2 - idle1) / (total2 - total1)).toFixed(2)
                textInd1 = (percent * 100).toFixed(0) + "%"
                textInd2 = indicator2 + "°C"
                total1 = total2
                idle1 = idle2
                return (percent, textInd1, textInd2)
            }
        }
    }

    // Process {
    //     id: memoryPerfomance

    // }

    // Process {
    //     id: checkInfo
    //     running: true

    //     command: {
    //         if (root.info3 === "GPU") {
    //             return [
    //                 "sh", "-c",
    //                 "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits"
    //             ]
    //         } else if (root.info3 === "CPU") {
    //             return [
    //                 "sh", "-c",
    //                 "awk 'NR == 1 { idle = $5 + $6; total = 0; for (i=2; i<=9; i++) total += $i; print idle, total}' /proc/stat && cat /sys/class/hwmon/hwmon3/temp1_input"
    //             ]
    //             } else {
    //             return [
    //                 "sh", "-c",
    //                 "awk 'NR<=3 && NR!=2 {print $2}' /proc/meminfo"
    //             ]
    //         }
    //     }

    //     stdout: StdioCollector {
    //         onStreamFinished: {
    //             // GPU Indicator
    //             if (root.info3 === "GPU") {
    //                 var info = this.text.trim().split(",")
    //                 indicator1 = parseInt(info[0])
    //                 indicator2 = parseInt(info[1])

    //                 textInd1 = indicator1 + "%"
    //                 textInd2 = indicator2 + "°C"
    //                 percent = indicator1 / 100
    //             // CPU Indicator
    //             } else if (root.info3 === "CPU") {
    //                 var info = this.text.trim().split(/\s+/)
    //                 const idle2 = parseInt(info[0])
    //                 const total2 = parseInt(info[1])
    //                 indicator2 = parseInt(info[2]) / 1000

    //                 percent = (1 - (idle2 - idle1) / (total2 - total1)).toFixed(2)
    //                 textInd1 = (percent * 100).toFixed(0) + "%"
    //                 textInd2 = indicator2 + "°C"
    //                 total1 = total2
    //                 idle1 = idle2
    //             // MEM Indicator
    //             } else {
    //                 var info = this.text.split("\n")
    //                 indicator1 = parseInt(info[0]) / 1024
    //                 indicator2 = parseInt(info[1]) / 1024

    //                 textInd1 = ((indicator1 - indicator2) / 1000).toFixed(2) + "Гб"
    //                 textInd2 = ((indicator2) / 1000).toFixed(2) + "Гб"
    //                 percent = (1 - (indicator2 * 100 / indicator1) / 100).toFixed(2)
    //             }
    //         }
    //     }
    // }
}