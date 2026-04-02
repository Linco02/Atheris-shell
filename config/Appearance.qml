pragma Singleton
import Quickshell

Singleton {
    readonly property var padding: Config.appearance.padding
    readonly property var colors: Config.colors
    readonly property var settings: Config.settings
}