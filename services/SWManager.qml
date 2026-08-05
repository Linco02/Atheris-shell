pragma Singleton
import Quickshell
import qs.config

Singleton {
    // AtherisCenter
    function controlAtherisCenter(targetWindow, targetMenu) {
        const isSameWindow = targetWindow === UIState.atherisCenterModule
        const isSameMenu = targetMenu === UIState.dashboardModul || !targetMenu

        if (UIState.isAtherisCenterOpen && isSameWindow && isSameMenu) {
            UIState.isAtherisCenterOpen = false
            return
        }

        if (targetMenu) UIState.dashboardModul = targetMenu
        UIState.atherisCenterModule = targetWindow
        UIState.isAtherisCenterOpen = true
    }

    // ControllCenter
    function controlCenter(targetMenu) {
        if (UIState.isControlCenterOpen) {
            UIState.isControlCenterOpen = false
            return
        }

        if (targetMenu) UIState.controlCenterModul = targetMenu
        UIState.isControlCenterOpen = true
    }
    
    // AtherisSettings
    function atherisSettings(targetMenu) {
        if (targetMenu) UIState.atherisSettingsModule = targetMenu
        else return
        UIState.isAtherisSettingsOpen = true
    }

}