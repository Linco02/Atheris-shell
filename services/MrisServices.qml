pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import qs.config

Singleton {
    property int playerChose: 0
    property var player: Mpris.players.values[playerChose]
    property bool playerIsPlay: player.playbackState === MprisPlaybackState.Playing
    property string playerIcon: player ? player.trackArtUrl : ""
    
    property var cavaBarsData: Array(cavaBarsCount).fill(0)
    property int cavaBarsCount: 40

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
        running: GlobalStates.isDashboardOpen
        command: [
            "sh", "-c", "cava -p ~/Atheris-shell/assets/cava.ini"
        ]

        stdout: SplitParser {
            onRead: data => {
                const raw = data.trim().split(";").map(n => parseInt(n) || 0)

                const normalized = Array(cavaBarsCount).fill(0).map(
                    (_, i) => raw[i] ?? 0
                )
                
                cavaBarsData = normalized
            }
        }
    }

}