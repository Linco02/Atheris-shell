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

    // CommandCenter
    property bool isCommandCenterOpen: false

    property string commandCenterModule: "dashboard"
    property string dashboardModul: "dash"
}