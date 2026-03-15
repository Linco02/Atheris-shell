pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

Singleton {
    Process {
        id: notifiSend
    }

    function send(name, text, urgency) {
        notifiSend.command = [
            "notify-send",
            name, text,
            "-u", urgency
        ]
        notifiSend.running = true
    }
}