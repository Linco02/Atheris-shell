import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config

PanelWindow {
    id: root
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    WlrLayershell.layer: WlrLayer.Background
    exclusiveZone: -1
    color: Appearance.surface

    Random { }
    Wallpaper {}
    // LazyLoader {
    //     // anchors.fill: parent
    //     asynchronous: false
    //     active: Settings.enableWallpaper
    //     component: Wallpaper {}
    // }
}