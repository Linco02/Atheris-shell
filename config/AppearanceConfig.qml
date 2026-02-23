import Quickshell.Io

JsonObject {
    property AnimDurations durations: AnimDurations {}
    property Padding padding: Padding {}

    component AnimDurations: JsonObject {
        property int fast: 200
        property int normal: 400
        property int slow: 800
    }

    component Padding: JsonObject {
        property int small: 5
        property int normal: 10
        property int large: 20
    }
}