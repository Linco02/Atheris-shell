pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    // Панель //
    property bool isBarOn: true
    // property bool isDetached: true
    property string barPosition: "bottom"

    // Задній план //
    property bool isBackgroundOn: true
    property bool isWallpaperOn: true
    property bool isRandomWallpaperOn: true
    property string wallpaperFolder: "/home/linco02/wallpapers/"
    property var wallpaperFormat: ["image", "anmf", "video"] // "image", "anmf", "video"
    property var chosenWallpapers: ({
        "HDMI-A-1": "",
        "eDP-1": ""
    })

    // Блокування //
    property bool isSessionLockOn: false

    // Палітра //
    property bool isAdaptivePalitOn: true
    property string palitMode: "dark" // dark, light
    property bool palitShellOn: true
    property bool palitOpenrgbOn: true
    property bool palitPywalFoxOn: true
    property bool palitKittyOn: true
    property bool palitqt6ctOn: true

    // Служби //  
    property bool isNotifiSoundOn: true
}