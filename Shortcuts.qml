import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config

Item {
    function openDashboard(target) {
        if (target === "dashboard") Global.dashboardModul = "dash"
        Global.isControlCenterOpen = (Global.controlCenterModul === target) ? !Global.isControlCenterOpen : true
        Global.controlCenterModul = target
    }

    GlobalShortcut {
        name: "dashboard_menu"
        description: "Відкрити дошку"
        onPressed: openDashboard("dashboard")
    }

    GlobalShortcut {
        name: "wallpaper_selector"
        description: "Відкрити вибір шпалер"
        onPressed: openDashboard("wallpaper")
    }

    GlobalShortcut {
        name: "programs_selector"
        description: "Відкрити програму"
        onPressed: openDashboard("command")
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