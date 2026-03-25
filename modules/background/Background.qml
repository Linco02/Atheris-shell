import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services

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
    color: Colors.surface

    function wallpaperOnStartup() {
        if (GlobalStates.isRandomWallpaperOn && Wallpapers.wallpaper === "" && Wallpapers.wallparersList.length > 0) {
            Wallpapers.wallpaperRandom()
        }
    }

    Loader {
        active: GlobalStates.isWallpaperOn
        anchors.fill: parent
        sourceComponent: Component {
            Wallpaper {}
        }
    }

    Connections {
        target: Wallpapers
        function onWallpaperReady() { wallpaperOnStartup() }
    }

    Component.onCompleted: { wallpaperOnStartup() }
}