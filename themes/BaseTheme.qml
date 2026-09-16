import QtQuick

QtObject {
    property real cornerRadius: 0
    property real buttonRadius: 0
    property bool useAngledShapes: false
    property real skewAngle: 0
    property int durations: 0
    property int indents: 0
    property int radius: 0
    
    property QtObject colors: QtObject {
        property color surface: "#191113"
        property color surfaceRaised: "#261d1f"
        property color outline: "#9e8c8f"
        property color active: "#ffb1c4"
        property color inactive: "#514346"
        property color warning: "#ffb4ab"

        property color textSurface: "#efdfe1"
        property color textAccent: "#703345"
        property color textInactive: "#d6c2c5"
    }
}