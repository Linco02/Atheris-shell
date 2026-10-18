pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import qs.config

import QtQuick

Singleton {
    property var player: Mpris.players.values ?? []
    property bool playerExist: player?.length > 0
    property bool isplayerActivePlay: checkIsPlaying(playerActive)
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
    property real playerActiveProgres: 0
    property var cavaBarsData: Array(Theme.cavaBarsCount).fill(0)
    property bool isCavaBarOn: UIState.isAtherisCenterOpen

    function checkIsPlaying(player) {
        return player?.playbackState === MprisPlaybackState.Playing ?? false
    }

    function next(player) {player.next()}
    function previous(player) {player.previous()}
    function pause(player) {player.pause()}
    function play(player) {player.play()}
    function setPosition(player, position) {
        player.position = position
    }

    Process {
        id: radialBars
        running: isCavaBarOn
        command: [
            "sh", "-c", "cava -p ~/Atheris-shell/assets/cava.ini"
        ]

        stdout: SplitParser {
            onRead: data => {
                cavaBarsData = data
                    .trim()
                    .split(";")
                    .filter(n => n !== "")
                    .map(n => parseInt(n) / 100 || 0)
            }
        }
    }

    Connections {
        target: STick
        enabled: playerExist
        function onTick1s() {
            playerActiveProgres = playerActive.position / playerActive.length
        }
    }   
}