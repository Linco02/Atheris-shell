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

    // property var workspacesTest: {
    //     let occupiedSet = new Set(workspaces.map(w => w.id));

    //     let ws = Array.from({length: 11}, (_, i) => {
    //         let id = i + 1;

    //         return {
    //             "id": id,
    //             "name": id === 11 ? "special:magic" : id,
    //             "isOccupied": workspaces.some(w => w.id === id),
    //             // "isFocused": id === 11 ? false : workspaces[id].focused
    //             "isFocused": false
    //         };
    //     });

    //     // for (let i = 0; i < ws.length; i++) {
    //     //     // console.log(ws[i].id)
    //     //     console.log(ws[i].isOccupied)
    //     // }

    //     return ws
    // }

    // property var workspacesTest: {
    //     let list = [];
    //     let occupiedSet = new Set(workspaces.map(w => w.id));
        
    //     for (let i = 1; i <= 11; i++) {
    //         list.push({
    //             "id": i,
    //             "name": i === 11 ? "special:magic" : i,
    //             "isOccupied": occupiedSet.has(i),
    //             "isFocused": false
    //         });
    //     }
    //     return list;
    // }

    // function updateWorkspaces() {
    //     let occupiedIds = new Set(workspaces.map(w => w.id));
        
    //     for (let item of workspacesTest) {
    //         item.isOccupied = occupiedIds.has(item.id);
    //     }
        
    //     workspacesTestChanged();
    // }


    // property var workspacesTest: {
    //     let list = [];
    //     for (let i = 1; i <= 11; i++) {
    //         list.push({
    //             "id": i,
    //             "name": i === 11 ? "special:magic" : i,
    //             "isOccupied": false,
    //             "isFocused": false
    //         });
    //     }
    //     return list;
    // }

    // // Функція оновлення за потребою
    // function updateWorkspaces() {
    //     let occupiedIds = new Set(workspaces.map(w => w.id));
        
    //     for (let item of workspacesTest) {
    //         item.isOccupied = occupiedIds.has(item.id);
    //     }
        
    //     // Сповіщаємо QML, що масив оновився
    //     workspacesTestChanged();
    // }

    ListModel {
        id: workspacesTest

        Component.onCompleted: {
            for (let i = 1; i <= 11; i++) {
                append({
                    "id": i,
                    "name": i === 11 ? "special:magic" : i.toString(),
                    "isOccupied": false,
                    "isFocused": false
                })
            }
        }
    }

    // 2. Оновлюємо тільки потрібні поля за допомогою setProperty
    function updateWorkspaces() {
        if (!workspaces) return;
        
        let occupiedSet = new Set(workspaces.map(w => w.id));

        for (let i = 0; i < workspacesTest.count; i++) {
            let item = workspacesTest.get(i);
            let nowOccupied = occupiedSet.has(item.wsId);
            
            // Змінюємо значення ТОЛЬКО якщо воно дійсно змінилося
            if (item.isOccupied !== nowOccupied) {
                workspacesTest.setProperty(i, "isOccupied", nowOccupied);
            }
        }
    }

    onWorkspacesChanged: updateWorkspaces()
}