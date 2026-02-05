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
    property real radius2: 30 * scale
    property real padding: 5 * scale
    property real spacing: 15 * scale

    // панелі
    property real topPanel: 32 * scale
    property real bottomPanel: 10 * scale
    property real leftPanel: 5 * scale
    property real rightPanel: 5 * scale

    // ========================
    // === палітра кольорів ===
    // ========================
    property color backGround: "#F19CBB"
    property color foreGround: "#E52B50"
    property color centerGround: "#F0F8FF"
    property color borderColor: "#FFBF00"
    property color activeColor: "#FFBF00"

    property color activeTextColor: "#F0F8FF"
    property color inactiveTextColor: "#F0F8FF"
}