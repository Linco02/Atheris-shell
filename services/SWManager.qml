pragma Singleton
import Quickshell
import qs.config

Singleton {
    // AtherisCenter
    function controlAtherisCenter(targetWindow, targetMenu) {
        const isSameWindow = targetWindow === UIState.atherisCenter.modul
        const isSameMenu = targetMenu === UIState.atherisCenter.dashboard.modul || !targetMenu

        if (UIState.atherisCenter.isOpen && isSameWindow && isSameMenu) {
            UIState.atherisCenter.isOpen = false
            return
        }

        if (targetMenu) UIState.atherisCenter.dashboard.modul = targetMenu
        UIState.atherisCenter.modul = targetWindow
        UIState.atherisCenter.isOpen = true
    }

    // ControllCenter
    function controlCenter(targetMenu) {
        const isSameMenu = targetMenu === UIState.controlCenter.modul || !targetMenu

        if (UIState.controlCenter.isOpen && isSameMenu) {
            UIState.controlCenter.isOpen = false
            return
        }

        if (targetMenu) UIState.controlCenter.modul = targetMenu
        UIState.controlCenter.isOpen = true
    }
    
    // AtherisSettings
    function atherisSettings(targetMenu) {
        if (targetMenu) UIState.atherisSettings.modul = targetMenu
        else return
        UIState.atherisSettings.isOpen = true
    }

    function atherisbase() {
        UIState.atherisBase.isOpen = !UIState.atherisBase.isOpen
    }
}