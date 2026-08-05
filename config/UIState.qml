pragma Singleton
import Quickshell

Singleton {
    // Lock
    property bool isSessionLock: false

    // Power
    property bool isPowerOpen: false

    // AtherisSettings
    property bool isAtherisSettingsOpen: false
    property var atherisSettingsModules: ["General", "Display", "Theme"]
    property string atherisSettingsModule: "Display"

    // ControlCenter
    property bool isControlCenterOpen: false
    property var controlCenterModules: ["sound", "wifi", "powerMode"]
    property string controlCenterModul: ""

    // AtherisCenter
    property bool isAtherisCenterOpen: false
    property string atherisCenterModule: "dashboard" // "dashboard", "wallpaper", "command"
    property string dashboardModul: "dash" // "dash", "music", "performance"
}