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
    property bool isAtherisSettingsOpen: true
    property var atherisSettingsModules: ["general", "display", "theme", "bluetooth", "network"]
    property string atherisSettingsModule: "general"

    // ControlCenter
    property bool isControlCenterOpen: false
    property var controlCenterModules: ["main", "sound", "wifi", "powerMode", "bluetooth"]
    property string controlCenterModul: "main"
    property var timerHubModules: ["timer", "stopWatch", "alarmСlock"]
    property string timerHubModule: "stopWatch"

    // AtherisCenter
    property bool isAtherisCenterOpen: false
    property string atherisCenterModule: "dashboard" // "dashboard", "wallpaper", "command"
    property string dashboardModul: "dash" // "dash", "music", "performance"
}