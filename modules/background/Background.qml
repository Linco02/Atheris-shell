import Quickshell
import Quickshell.Wayland
import qs.components.animations
import qs.config
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
        active: Settings.isWallpaperOn
        anchors.fill: parent
        sourceComponent: Component {
            Wallpaper { }
        }
    }

    Behavior on color { ColorAnim { } }
}