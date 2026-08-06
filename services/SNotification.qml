pragma Singleton
import QtQuick
import QtMultimedia
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import qs.config

Singleton {
    property alias server: notificationServer

    function nitifiSend(appName, summary, body, iconName, urgency, timeout, replacesId) {
        notifiSend.command = [
            "notify-send",
            summary, body,
            "-a", appName,
            "-r", replacesId,
            "-i", iconName,
            "-u", urgency,
            "-t", timeout
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

    SoundEffect {id: playNotifi}

    NotificationServer {
        id: notificationServer
        
        onNotification: (notification) => {
            notification.tracked = true;

            if (Settings.isNotifiSoundOn)
                notifiSound()
        }
    }

    Process {
        id: notifiSend
    }
}