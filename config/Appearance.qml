pragma Singleton
import QtQuick
import Quickshell

Singleton {
    // =======================
    // === загальні змінні ===
    // =======================

    readonly property AppearanceConfig.AnimDurations durations: Config.appearance.durations
    readonly property AppearanceConfig.Padding padding: Config.appearance.padding
    readonly property AppearanceConfig.Spacing spacing: Config.appearance.spacing
    readonly property AppearanceConfig.Radius radius: Config.appearance.radius

    // ========================
    // === поодинокі змінні ===
    // ========================

    // масштаб
    property real scale: 1

    // розмір панелі
    property real barHeight: 34 * scale

    // шрифт
    property string fontFamily: "FiraCode Nerd Font"
}