pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io

Singleton {
    property var sink: Pipewire.defaultAudioSink
    property real volume: sink?.audio?.volume ?? 0
    property bool muted: sink?.audio?.muted ?? false
    property string iconVolume: PipewireServices.muted ? "󰖁"
        : volume > 0.7 ? "󰕾"
        : volume > 0.4 ? "󰖀"
        : volume > 0 ? "󰕿"
        : "󰝟" 

    function pavucontrolOpen() {
        pavucontrol.running = true
    }

    function toggleMute() {
        sink.audio.muted = !sink.audio.muted
    }

    function setVolume(v) {
        sink.audio.volume = Math.max(0, Math.min(1, v))
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Process {
        id: pavucontrol
        command: [ "pavucontrol" ]
    }
}