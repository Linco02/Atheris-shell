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

    // AtherisSettings
    
}