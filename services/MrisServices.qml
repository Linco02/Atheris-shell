pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris

Singleton {
    property var cavaBarsData: Array(20).fill(0)
    property int cavaBarsCount: 20

    function nextMris(player) {
        player.next()
    }

    function previousMris(player) {
        player.previous()
    }

    function pauseMris(player) {
        player.pause()
    }

    function playMris(player) {
        player.play()
    }

    function setPositionMris(player, position) {
        player.position = position
    }

    Process {
        id: cavaData
        running: true
        command: [
            "sh", "-c", "cava -p ~/Atheris-shell/assets/cava.ini"
        ]

        stdout: SplitParser {
            onRead: data => {
                const raw = data.trim().split(";").map(n => parseInt(n) || 0)
                
                // Якщо менше 20 — доповнюємо нулями
                // Якщо більше 20 — обрізаємо
                const normalized = Array(cavaBarsCount).fill(0).map(
                    (_, i) => raw[i] ?? 0
                )
                
                cavaBarsData = normalized
            }
        }
    }
}