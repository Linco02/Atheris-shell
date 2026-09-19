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
    property var eworkspaces: {
        return Array.from({length: existingQuantityWorkspaces}, (_, i) => {
            const id = i + 1;
            const found = workspaces.find(w => w.id === id);

            const neighbor = {
                previous: workspaces.some(w => w.id === id - 1),
                following: workspaces.some(w => w.id === id + 1)
            }
            
            if (found) {
                return {
                    workspace: found,
                    id: found.id,
                    name: found.name,
                    focused: found.focused,
                    occupied: true,
                    neighbor
                };
            }

            return {
                id: id,
                name: id.toString(),
                occupied: false,
                neighbor
            };
        })
    }

    // function getWorkspace(name) {
    //     if (!workspaces) return null;
    //     return workspaces.find(
    //         w => w.name.toString() === name.toString() || w.id === name
    //     ) || null;
    // }

    function moveToWorkspace(ws) {
        if (ws.name === "special:magic") {
            Hyprland.dispatch("togglespecialworkspace magic");
        } else {
            if (ws.focused) return;
            Hyprland.dispatch(`workspace ${ws.name}`);
        };
    }
}