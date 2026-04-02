import Quickshell.Io

JsonObject {
    property AnimDurations durations: AnimDurations {}
    property Padding padding: Padding {}
    property Spacing spacing: Spacing {}
    property Radius radius: Radius {}
    property Margine margine: Margine {}

    property real scale: 1

    component AnimDurations: JsonObject {
        property int fast: 200 * scale
        property int normal: 400 * scale
        property int slow: 800 * scale
    }

    component Margine: JsonObject {
        property int small: 5 * scale
        property int normal: 10 * scale
        property int large: 20 * scale
        property int gigant: 40 * scale
    }

    component Padding: JsonObject {
        property int small: 5 * scale
        property int normal: 10 * scale
        property int large: 20 * scale
        property int gigant: 40 * scale
    }

    component Spacing: JsonObject {
        property int small: 5 * scale
        property int normal: 10 * scale
        property int large: 20 * scale
        property int gigant: 40 * scale
    }

    component Radius: JsonObject {
        property int small: 10 * scale
        property int normal: 15 * scale
        property int large: 20 * scale
    }
}