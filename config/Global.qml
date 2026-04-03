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

    // ControlCenter
    property bool isDashboardOpen: false
    property string isDashboardModule: "dashboard"

    // Wallpaper
    property string wallpaperCurrent: "file:///home/linco02/wallpapers/Study 01 by Nixeu.jpg"
}