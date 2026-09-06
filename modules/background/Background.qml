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

    property bool isLoad: false

    Loader {
        active: Settings.isWallpaperOn && StartUp.isWallaperThumbnailDirCreate && isLoad
        anchors.fill: parent
        sourceComponent: Wallpaper {}
    }

    Behavior on color {ColorAnim {}}
    Component.onCompleted: isLoad = true
}