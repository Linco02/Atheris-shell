pragma Singleton
import QtQuick
import Quickshell

Singleton {
    readonly property AppearanceConfig.AnimDurations durations: Config.appearance.durations
    readonly property AppearanceConfig.Padding padding: Config.appearance.padding
    readonly property AppearanceConfig.Spacing spacing: Config.appearance.spacing
    readonly property AppearanceConfig.Radius radius: Config.appearance.radius
    // =======================
    // === загальні змінні ===
    // =======================

    // масштаб
    property real scale: 1
    
    // property real padding: 5 * scale
    property real padding2x: padding * 2
    // property real spacing: 10 * scale

    property real barHeight: 34 * scale
    property real bottomPanel: 34 * scale

    // ======================
    // === Шрифт та текст ===
    // ======================

    property real fontSize: 12
    property string fontFamily: "FiraCode Nerd Font"
}