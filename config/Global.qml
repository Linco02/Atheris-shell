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
    property bool isAnythingOpen: isPowerOpen || isCommandCenterOpen || isControlCenterOpen

    // Floating
    property bool isAtherisSettingsOpen: false

    // Power
    property bool isPowerOpen: false

    // ControlCenter
    property bool isControlCenterOpen: false
    property var controlCenterModules: ["sound", "wifi"]
    property string controlCenterModul: ""

    // Lock
    property bool isSessionLock: false

    // ControlCenter
    property bool isCommandCenterOpen: false
    property var commandCenterModules: [
        {label: "wallpaper", icon: ""},
        {label: "dashboard", icon: "󰨝"},
        {label: "command", icon: ""},
    ]
    property string commandCenterModule: "dashboard"
    property string dashboardModul: "dash"

    // Wallpaper
    property string wallpaperCurrent: "file:///home/linco02/wallpapers/liquid-art-paint-3840x2160-25904.jpg"

    // TEMP
    property string palitMode: "dark" // Palit.palitCreate()
}