pragma Singleton
import QtQuick
import Quickshell
import qs.config
import qs.themes

Singleton {
    id: root

    property string currentTheme: "Celend-4"
    property var avalibleThemes: ["Atheris", "Celend-4"]
    readonly property AtherisTheme atherisTheme: AtherisTheme {}
    readonly property Celend4 celend4Theme: Celend4 {}
    readonly property QtObject theme: currentTheme === "Base"
        ? baseTheme : currentTheme === "Atheris"
        ? atherisTheme : currentTheme === "Celend-4"
        ? celend4Theme : baseTheme

    property int scale: 1

    property QtObject colors: Settings.isAdaptivePalitOn && Settings.palitShellOn
        ? SPalit.colors || theme.colors : theme.colors

    readonly property QtObject durations: QtObject {
        property int slow: theme.durations * 2
        property int normal: theme.durations
        property int fast: theme.durations * 0,5
    }
    
    readonly property QtObject padding: QtObject {
        property int small: Math.round((theme.indents * 0.5 * scale) / 2) * 2
        property int normal: theme.indents * scale
        property int large: theme.indents * 2 * scale
    }

    readonly property alias margine: root.padding
    readonly property alias spacing: root.padding

    readonly property QtObject radius: QtObject {
        property int small: theme.radius * 0.5
        property int normal: theme.radius
        property int large: theme.radius * 2
    }

    readonly property QtObject stock: QtObject {
        property int small: theme.useAngledShapes ? 0 : padding.small * 2
        property int normal: theme.useAngledShapes ? 0 : padding.normal * 2
        property int large: theme.useAngledShapes ? 0 : padding.large * 2
    }

    readonly property QtObject unitSize: QtObject {
        property int small: theme.unitSize
        property int normal: theme.unitSize * 2
        property int large: theme.unitSize * 4
    }
}