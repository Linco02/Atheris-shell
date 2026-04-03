pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import qs.config

import QtQuick

Singleton {
    property var player: Mpris.players.values
    property bool playerExist: player.length > 0 ? true : false
    property bool isplayerActivePlay: playerExist ? playerActive.playbackState === MprisPlaybackState.Playing : false
    property var playerActive: {
        if (!playerExist)
            return null;

        let playerPlaying = player.filter(p => p.playbackState === MprisPlaybackState.Playing);
        
        if (playerPlaying.length > 1)
            return playerPlaying[0];
        else if (playerPlaying.length === 1)
            return playerPlaying[0];
        else
            return player[0];
    }
    property var cavaBarsData: Array(Global.appearance.cavaBarsCount).fill(0)

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
        running: Global.isDashboardOpen
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