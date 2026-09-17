pragma Singleton
import QtQuick
import Quickshell
import qs.themes
import qs.services

Singleton {
    property real opacity: 0.99

    property real barWidth: 28

    property int workspaceNumber: 5

    property string fontFamily: "FiraCode Nerd Font"
    property int fontSize: 14

    readonly property var theme: STheme.theme
    readonly property var colors: STheme.colors
    readonly property var durations: STheme.durations
    readonly property var padding: STheme.padding
    readonly property var margine: STheme.margine
    readonly property var spacing: STheme.spacing
    readonly property var radius: STheme.radius

    property int cavaBarsCount: 40
}