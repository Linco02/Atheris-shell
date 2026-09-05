pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import qs.config

Singleton {
    property alias server: notificationServer
    property var notifations: server.trackedNotifications.values

    function sendNotification (appName, summary, body, iconName, urgency, timeout, replacesId) {
        notifi.command = [
            "notify-send",
            summary, body,
            "-a", appName,
            "-r", replacesId,
            "-i", iconName,
            "-u", urgency, //low, normal, critical
            "-t", timeout
        ]
        notifi.running = true
    }

    function clearNotification (notifi) {
        notifi.dismiss()
    }

    function clearNotifications () {
        cleatTime.running = true
    }

    Timer {
        id: cleatTime
        interval: 100; repeat: true
        onTriggered: {
            if (notifations.length > 0) clearNotification(notifations[0])
            else running = false
        }
    }

    NotificationServer {
        id: notificationServer
        
        onNotification: (notification) => {
            notification.tracked = true

            if (Settings.isNotifiSoundOn) SSystemSound.playNotification()
        }
    }

    Process {
        id: notifi
    }
}