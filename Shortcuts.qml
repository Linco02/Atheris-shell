import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config

Item {
    function openDashboard(target) {
        Global.isDashboardOpen = (Global.isDashboardModule === target) ? !Global.isDashboardOpen : true
        Global.isDashboardModule = target
    }

    // GlobalShortcut {
    //     name: "dashboard_menu"
    //     description: "Відкрити дошку"
    //     onPressed: openDashboard("dashboard")
    // }

    GlobalShortcut {
        name: "wallpaper_selector"
        description: "Відкрити вибір шпалер"
        onPressed: openDashboard("wallpaper")
    }

    // GlobalShortcut {
    //     name: "programs_selector"
    //     description: "Відкрити програму"
    //     onPressed: openDashboard("programs")
    // }

    // GlobalShortcut {
    //     name: "lock_session"
    //     description: "Заблокувати сесію"
    //     onPressed: { Global.isSessionLockOn = true }
    // }
}