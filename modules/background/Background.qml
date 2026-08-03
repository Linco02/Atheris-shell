import Quickshell
import Quickshell.Wayland
import qs.core
import qs.config
import qs.components.animations
import QtQuick

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
    color: Theme.surfaceRaised

    Loader {
        active: Settings.isWallpaperOn && StartUp.isWallaperThumbnailDirCreate
        anchors.fill: parent
        sourceComponent: Wallpaper { }
    }

    Behavior on color { ColorAnim { } }
}