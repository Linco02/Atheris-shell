pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config

Singleton {
    property var workspaceFocused: Hyprland.focusedWorkspace?.id ?? 1
    property int workspaceNumber: Global.appearance.workspaceNumber
    property int workspaceExist: workspaceNumber
    property list<bool> workspaceOccupied: []

    Connections {
        target: Hyprland.workspaces
        function onValuesChanged() { updateExist() }
    }

    function updateExist() {
        let maxId = Hyprland.workspaces.values.reduce((max, ws) => {
            return (ws.id > max) ? ws.id : max
        }, 1);
        workspaceExist = Math.max(maxId, workspaceNumber)

        updateOccupied()
    }

    function updateOccupied() {
        workspaceOccupied = Array.from({length: workspaceExist}, (_,i) => {
            return Hyprland.workspaces.values.some(ws => ws.id === (i + 1));
        })
    }

    function workspaceMove(ws) {
        Hyprland.dispatch(`workspace ${ws + 1}`)
    }

    Component.onCompleted: { updateExist() }
}