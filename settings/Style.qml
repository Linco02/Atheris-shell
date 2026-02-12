pragma Singleton
import QtQuick

QtObject {
    // =======================
    // === загальні змінні ===
    // =======================

    // масштаб
    property real scale: 1
    
    // декорація
    property real radius: 15 * scale
    property real radius2: 20 * scale
    property real padding: 5 * scale
    property real spacing: 5 * scale

    // панелі
    property real topPanel: 32 * scale
    property real bottomPanel: 15 * scale
    property real leftPanel: 10 * scale
    property real rightPanel: 10 * scale

    // ======================
    // === Шрифт та текст ===
    // ======================

    property real fontSize: 12
    property string fontFamily: "FiraCode Nerd Font"

    // ===================================
    // === палітра кольорів та шпалери ===
    // ===================================

    // шпалери
    property var imagesList: []
    property url images: ""

    // згенерована палітра
    property color color1: "transparent"
    property color color2: "transparent"
    property color color3: "transparent"
    property color color4: "transparent"
    property color color5: "transparent"
    property color color6: "transparent"
    property color color7: "transparent"
    property color color8: "transparent"

    // колір елементів
    property color panelColor: color2
    property color backGround: color3
    property color foreGround: "#E52B50"
    property color centerGround: "#F0F8FF"
    property color borderColor: "#FFBF00"
    property color activeColor: "#FFBF00"

    property color activeTextColor: "#F0F8FF"
    property color inactiveTextColor: "#F0F8FF"
}