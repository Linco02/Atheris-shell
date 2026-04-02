pragma Singleton
import Quickshell

Singleton {
    readonly property var durations: Config.durations.padding
    readonly property var padding: Config.appearance.padding
    readonly property var spacing: Config.appearance.spacing
    readonly property var radius: Config.appearance.radius
    readonly property var margine: Config.appearance.margine
    readonly property var settings: Config.settings

    // ControlCenter
    property bool isDashboardOpen: false
    property string isDashboardModule: "dashboard"

    // Wallpaper
    property string wallpaperCurrent: "file:///home/linco02/wallpapers/Dark Queen 4K live wallpaper.mp4"
}