pragma Singleton
import QtQuick
import QtMultimedia
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import qs.config

Singleton {
    property alias server: notificationServer

    NotificationServer {
        id: notificationServer
        
        onNotification: (notifi) => {
            notifi.tracked = true;

            if (GlobalStates.isNotifiSoundOn)
                notifiSound()
        }
    }

    Process {
        id: notifiSend
    }

    // urgency(low/normal/critical)
    function send(name, text, urgency) {
        notifiSend.command = [
            "notify-send",
            name, text,
            "-u", urgency
        ]
        notifiSend.running = true
    }

    function notifiSound(urgency) {
        if (urgency === "critical")
            playNotifi.source = "../assets/notifiAllert.wav"
        else
            playNotifi.source = "../assets/notifiNormal.wav"

        playNotifi.play()
    }

    SoundEffect { id: playNotifi }
}