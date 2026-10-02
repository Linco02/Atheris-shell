pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config

Singleton {
    property int desiredQuantityWorkspaces: 5
    property bool showSpecialWorkspace: false
    readonly property int focusedId: Hyprland.focusedWorkspace?.id ?? -1
    readonly property int maxExistId: Math.max(desiredQuantityWorkspaces, ...workspaces.map(w => w.id))
    readonly property var workspaces: Hyprland?.workspaces.values
        .filter(w => w.name !== (showSpecialWorkspace ? "" : "special:magic")) ?? []
    readonly property var workspacesList: ListModel {
        id: workspacesTest

        Component.onCompleted: {
            for(let i = 1; i <= 11; i++) {
                append({
                    "wsId": i,
                    "name": (i === 11 ? "special:magic" : i).toString(),
                    "isOccupied": false,
                    "isFocused": false,
                    "previousNeighbor": false,
                    "followingNeighbor": false
                })
            }

            updateWorkspaces()
        }
    }

    onFocusedIdChanged: updateWorkspaces()
    onWorkspacesChanged: updateWorkspaces()

    function updateWorkspaces() {
        const occupied = new Set(workspaces.map(w => w.id))
        const focused = new Set(workspaces.filter(w => w.focused).map(w => w.id))

        for (let i = 0; i < workspacesTest.count; i++) {
            const id = workspacesTest.get(i).wsId
            const neighbor = hasNeighbor(id)

            workspacesTest.setProperty(i, "isOccupied", occupied.has(id))
            workspacesTest.setProperty(i, "isFocused", focused.has(id))
            workspacesTest.setProperty(i, "previousNeighbor", neighbor.previous)
            workspacesTest.setProperty(i, "followingNeighbor", neighbor.following)
        }
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