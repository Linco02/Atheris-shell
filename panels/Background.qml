import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.settings
import qs.widgets

PanelWindow {
    id: background
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    WlrLayershell.layer: WlrLayer.Background
    color: "transparent"

    Wallpaper {}
}