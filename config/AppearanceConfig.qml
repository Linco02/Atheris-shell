import Quickshell
import Quickshell.Io

JsonObject {
    property AnimDurations durations: AnimDurations {}
    property Padding padding: Padding { }
    property Spacing spacing: Spacing { }
    property Radius radius: Radius { }
    property Margine margine: Margine { }

    // масштаб
    property real scale: 1
    // hover ефект
    property real hover: 1.5
    // Задній фон
    property real opacity: 1
    property bool glassEfect: true
    // розмір панелі
    property real barHeight: 34 * scale
    // кількість worckspace
    property int workspaceNumber: 5
    // кількість cavaBars
    property int cavaBarsCount: 40
    // шрифт
    property string fontFamily: "FiraCode Nerd Font"

    component AnimDurations: JsonObject {
        property int fast: 200 * scale
        property int normal: 400 * scale
        property int slow: 800 * scale
    }

    component Margine: JsonObject {
        property real scale: 1
        property int small: 5 * scale
        property int normal: 10 * scale
        property int large: 20 * scale
        property int gigant: 40 * scale
    }

    component Padding: JsonObject {
        property real scale: 1
        property int mini: 3 * scale
        property int small: 5 * scale
        property int normal: 10 * scale
        property int large: 20 * scale
        property int gigant: 40 * scale
    }

    component Spacing: JsonObject {
        property real scale: 1
        property int small: 5 * scale
        property int normal: 10 * scale
        property int large: 20 * scale
        property int gigant: 40 * scale
    }

    component Radius: JsonObject {
        property real scale: 1
        property int small: 10 * scale
        property int normal: 15 * scale
        property int large: 20 * scale
    }
}