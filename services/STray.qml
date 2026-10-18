pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Singleton {
    property var trays: SystemTray.items.values
        .filter(t => t.title !== "") || []
    property int traysCount: trays?.length || 0
}