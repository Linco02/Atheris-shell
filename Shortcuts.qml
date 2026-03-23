import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config

Item {
    GlobalShortcut {
        name: "dashboard_menu"
        description: "Відкрити дошку"
        onPressed: {
            // GlobalStates.isWallpaperSelector = false
            // GlobalStates.isDashboard = !GlobalStates.isDashboard
            GlobalStates.isDashboardModule = "dashboard"
        }
    }

    GlobalShortcut {
        name: "wallpaper_selector"
        description: "Відкрити вибір шпалер"
        onPressed: {
            // GlobalStates.isDashboard = false
            // GlobalStates.isWallpaperSelector = !GlobalStates.isWallpaperSelector
            GlobalStates.isDashboardModule = "wallpaper"
        }
    }

    GlobalShortcut {
        name: "programs_selector"
        description: "Відкрити програму"
        onPressed: {
            GlobalStates.isDashboardModule = "programs"
        }
    }

    GlobalShortcut {
        name: "lock_session"
        description: "Заблокувати сесію"
        onPressed: { GlobalStates.isSessionLockOn = true }
    }
}