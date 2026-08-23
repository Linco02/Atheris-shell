pragma Singleton
import QtQuick
import Quickshell
import qs.config

Singleton {
    property var command: Icon.commandCenterModules.filter(m => m.label !== "command")
    property var directory: [{label: "directory", icon: "D"}]
    property var applications: SDesktop.desktopEntries.values
    property var currentList: applications
    property string currentMode: "applications"

    function updateList(input) {
        let cleanInput = (input || "").trim()

        if (input.startsWith(">")) {
            currentMode = "command"
            cleanInput = cleanInput.slice(1).trim()
        } else if (input.startsWith("/")) {
            currentMode = "directory"
            cleanInput = cleanInput.slice(1).trim()
        } else {
            currentMode = "applications"
        }

        const search = cleanInput.toLowerCase();

        if (currentMode === "command") {
            currentList = search === "" 
                ? command 
                : command.filter(m => m && m.label && m.label.toLowerCase().includes(search))
        } else if (currentMode === "directory") {
            currentList = directory
        } else if (currentMode === "applications") {
            currentList = applications.filter(app => app.name.toLowerCase().includes(search))
        } else return
    }
}