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
    color: Style.foreGround

    Wallpaper {}
    // LazyLoader {
    //     // anchors.fill: parent
    //     asynchronous: false
    //     active: Settings.enableWallpaper
    //     component: Wallpaper {}
    // }
}