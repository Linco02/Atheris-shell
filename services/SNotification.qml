pragma Singleton
import QtQuick
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
            "-u", urgency, //low, normal, critical
            "-t", timeout
        ]
        notifiSend.running = true
    }

    NotificationServer {
        id: notificationServer
        
        onNotification: (notification) => {
            notification.tracked = true;

            if (Settings.isNotifiSoundOn)
                SSystemSound.playNotification()
        }
    }

    Process {
        id: notifiSend
    }
}