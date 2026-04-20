pragma Singleton
import QtQuick
import Quickshell
import qs.config

Singleton {
    property var command: Global.commandCenterModules.filter(m => m.label !== "command")
    property var directory: [{label: "directory", icon: "D"}]
    property var applications: [{label: "applications", icon: "A"}]

}