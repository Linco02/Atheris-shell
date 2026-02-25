import Quickshell.Io

JsonObject {
    property AnimDurations durations: AnimDurations {}
    property Padding padding: Padding {}
    property Spacing spacing: Spacing {}
    property Radius radius: Radius {}

    component AnimDurations: JsonObject {
        property int fast: 200
        property int normal: 400
        property int slow: 800
    }

    component Padding: JsonObject {
        property int small: 5
        property int normal: 10
        property int large: 20
        property int gigant: 40
    }

    component Spacing: JsonObject {
        property int small: 5
        property int normal: 10
        property int large: 20
        property int gigant: 40
    }

    component Radius: JsonObject {
        property int small: 10
        property int normal: 15
        property int large: 20
    }
}