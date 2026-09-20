pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config

Singleton {
    property int desiredQuantityWorkspaces: 5
    property int existingQuantityWorkspaces: Math.max(...workspaces.map(w => w.id), desiredQuantityWorkspaces)
    property bool showSpecialWorkspace: false
    property var workspaces: Hyprland?.workspaces.values
        .filter(w => w.name !== (showSpecialWorkspace ? "" : "special:magic")) ?? []

    function getWorkspace(name) {
        if (!workspaces) return null;
        return workspaces.find(
            w => w.name.toString() === name.toString() || w.id === name
        ) || null;
    }

    function getOccupied(ws) {
        if (!ws) return false
        return workspaces.some(w => w.name === ws.id.toString())
    }

    function hasNeighbor(name) {
        return {
            previous: workspaces.some(w => w.id === name - 1),
            following: workspaces.some(w => w.id === name + 1)
        }
    }

    function moveToWorkspace(name, focused) {
        if (name === "special:magic") {
            Hyprland.dispatch("togglespecialworkspace magic");
        } else {
            if (focused) return;
            Hyprland.dispatch(`workspace ${name}`);
        };
    }
}