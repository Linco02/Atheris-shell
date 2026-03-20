import QtQuick
import Quickshell
import Quickshell.Hyprland

Item {
    GlobalShortcut {
        name: "dashboard_menu"
        description: "Відкрити дошку"
        onPressed: {
            console.log("dash")
        }
    }

    GlobalShortcut {
        name: "wallpaper_selector"
        description: "Відкрити вибір шпалер"
        onPressed: {
            console.log("wall")
        }
    }
}