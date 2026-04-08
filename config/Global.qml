pragma Singleton
import Quickshell

Singleton {
    readonly property var appearance: Config.appearance
    readonly property var durations: appearance.durations
    readonly property var padding: appearance.padding
    readonly property var spacing: appearance.spacing
    readonly property var radius: appearance.radius
    readonly property var margine: appearance.margine
    readonly property var settings: Config.settings

    // Popups
    property bool isAnythingOpen: isPowerOpen || isControlCenterOpen

    // Power
    property bool isPowerOpen: false

    // Lock
    property bool isSessionLock: false

    // ControlCenter
    property bool isControlCenterOpen: false
    property var controlCenterModules: [
        {label: "wallpaper", icon: ""},
        {label: "dashboard", icon: "󰨝"},
        {label: "command", icon: ""},
    ]
    property string controlCenterModul: "dashboard"
    property string dashboardModul: "dash"

    // Wallpaper
    property string wallpaperCurrent: "file:///home/linco02/wallpapers/b-003.jpg"
}