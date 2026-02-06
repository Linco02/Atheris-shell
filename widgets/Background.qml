import QtQuick
import Quickshell
import Quickshell.Wayland
// import qs.backend
import qs.singles

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
    WallpaperChoser {}
}