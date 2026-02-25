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

    // ===================================
    // === палітра кольорів та шпалери ===
    // ===================================
    // шпалери
    property url wallpaper: ""

    // Базова палітра
    property color base:      "#031523"  // color1 — найтемніший фон
    property color mantle:    "#151c2c"  // color2 — трохи світліший фон
    property color overlay:   "#484662"  // color3 — оверлеї, неактивне
    property color muted:     "#4c6383"  // color4 — приглушені елементи
    property color subtle:    "#655273"  // color5 — subtle акценти
    property color accent:    "#635980"  // color6 — основний акцент
    property color highlight: "#755675"  // color7 — highlight акцент
    property color rose:      "#d2778b"  // color8 — попередження, активне

    // Семантичні кольори
    property color surface:          base
    property color surfaceRaised:    mantle
    property color outline:          accent
    property color active:           accent
    property color inactive:         overlay
    property color warning:          rose

    property color textSurface:        "white"
    property color textAccent:         rose
    property color textInactive:       base
}