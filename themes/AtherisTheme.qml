import QtQuick

BaseTheme {
    property real cornerRadius: 0
    property real buttonRadius: 0
    property bool useAngledShapes: false
    property real skewAngle: 0
    property int durations: 400
    property int indents: 10
    property int radius: 0

    colors: QtObject {
        property color surface: "#101410"
        property color surfaceRaised: "#1c211b"
        property color outline: "#8c9389"
        property color active: "#9ed49d"
        property color inactive: "#424940"
        property color warning: "#ffb4ab"

        property color textSurface: "#e0e4db"
        property color textAccent: "#205026"
        property color textInactive: "#c2c9bd"
    }
}