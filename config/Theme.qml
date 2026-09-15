pragma Singleton
import QtQuick
import Quickshell
import qs.themes

Singleton {
    property string currentTheme: "Base"
    property var avalibleThemes: ["Base", "Atheris"]

    readonly property BaseTheme baseTheme: BaseTheme {}
    readonly property AtherisTheme atherisTheme: AtherisTheme {}
    readonly property QtObject theme: currentTheme === "Base"
        ? baseTheme : atherisTheme

    readonly property QtObject colors: baseTheme.colors
}