pragma Singleton
import Quickshell

Singleton {
    // Lock
    property bool isSessionLock: false

    // Power
    property bool isPowerOpen: false

    // Auntefication
    property bool isAuthenficatorOpen: false

    // AtherisSettings
    property bool isAtherisSettingsOpen: false
    property var atherisSettingsModules: ["general", "display", "theme"]
    property string atherisSettingsModule: "display"

    // ControlCenter
    property bool isControlCenterOpen: false
    property var controlCenterModules: ["main", "sound", "wifi", "powerMode"]
    property string controlCenterModul: "main"

    // AtherisCenter
    property bool isAtherisCenterOpen: false
    property string atherisCenterModule: "dashboard" // "dashboard", "wallpaper", "command"
    property string dashboardModul: "dash" // "dash", "music", "performance"
}