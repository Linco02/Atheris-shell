pragma Singleton
import QtQuick
import Quickshell

Singleton {
    property color surface: Qt.alpha("#191113", Style.opacity)
    property color surfaceRaised: "#261d1f"
    property color outline: "#9e8c8f"
    property color active: "#ffb1c4"
    property color inactive: "#514346"
    property color warning: "#ffb4ab"

    property color textSurface: "#efdfe1"
    property color textAccent: "#703345"
    property color textInactive: "#d6c2c5"
}