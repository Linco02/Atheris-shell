import Quickshell.Io

JsonObject {
    // Панель //
    property bool isBarOn: true

    // Задній план //
    property bool isBackgroundOn: true
    property bool isWallpaperOn: true
    property bool isRandomWallpaperOn: true
    property string wallpaperFolder: "/home/linco02/wallpapers/"
    property var wallpaperFormat: ["image", "anmf", "video"] // "image", "anmf", "video"

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