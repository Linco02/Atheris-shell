pragma Singleton
import Quickshell
import QtMultimedia
import qs.config

Singleton {
    readonly property url notificationSound: "../assets/notifiSound.wav"
    readonly property url errorSound: "../assets/errorSound.wav"

    function playNotification() {
        playSound(notificationSound)
    }

    function playError() {
        playSound(errorSound)
    }

    function playSound(soundUrl) {
        if(!Settings.isNotifiSoundOn || Settings.isDndOn) return

        playNotifi.source = soundUrl
        playNotifi.play()
    }

    SoundEffect {id: playNotifi}
}