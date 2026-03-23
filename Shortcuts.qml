import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config

Item {
    GlobalShortcut {
        name: "dashboard_menu"
        description: "Відкрити дошку"
        onPressed: {
            let target = "dashboard"
            GlobalStates.isDashboardOpen = (GlobalStates.isDashboardModule === target) ? !GlobalStates.isDashboardOpen : true
            GlobalStates.isDashboardModule = target
        }
    }

    GlobalShortcut {
        name: "wallpaper_selector"
        description: "Відкрити вибір шпалер"
        onPressed: {
            let target = "wallpaper"
            GlobalStates.isDashboardOpen = (GlobalStates.isDashboardModule === target) ? !GlobalStates.isDashboardOpen : true
            GlobalStates.isDashboardModule = target
        }
    }

    GlobalShortcut {
        name: "programs_selector"
        description: "Відкрити програму"
        onPressed: {
            let target = "programs"
            GlobalStates.isDashboardOpen = (GlobalStates.isDashboardModule === target) ? !GlobalStates.isDashboardOpen : true
            GlobalStates.isDashboardModule = target
        }
    }

    GlobalShortcut {
        name: "lock_session"
        description: "Заблокувати сесію"
        onPressed: { GlobalStates.isSessionLockOn = true }
    }
}