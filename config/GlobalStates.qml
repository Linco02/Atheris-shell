pragma Singleton
import Quickshell
import qs.services

Singleton {
    // Панель //
    property bool isBarOn: true
    property bool isDashboardOpen: false
    property string isDashboardModule: "dashboard"

    // Задній план //
    property bool isBackgroundOn: true
    property bool isWallpaperOn: true
    property bool isRandomWallpaperOn: false
    property string wallpaperCurrent: "file:///home/linco02/wallpapers/Dark Queen 4K live wallpaper.mp4"

    // Блокування //
    property bool isSessionLockOn: false

    // Палітра //
    property bool isPalitOn: true
    property bool palitShellOn: true
    property bool palitOpenrgbOn: true
    property bool palitPywalFoxOn: true
    property bool palitKittyOn: true
    property bool palitqt6ctOn: true

    // Служби //  
    property bool isShortcutOn: true
    property bool isNotifiSoundOn: true
}