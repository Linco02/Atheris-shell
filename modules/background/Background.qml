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
    color: Theme.colors.surfaceRaised

    property bool isLoad: false
    readonly property string barPosition: Settings.barPosition ?? "top"
    readonly property bool isHorizontal: UIState.isHorizontal

    Loader {
        active: Settings.isWallpaperOn && StartUp.isWallaperThumbnailDirCreate && isLoad
        anchors.fill: parent
        sourceComponent: Wallpaper {}
    }

    Loader {
        active: Settings.isWidgetsOn && isLoad
        anchors {
            left: barPosition === "right" ? parent.left : undefined
            right: barPosition === "left" ? parent.right : undefined
            top: barPosition === "bottom" ? parent.top : undefined
            bottom: barPosition === "top" ? parent.bottom : undefined
        }
        height: parent.height - (isHorizontal ? Theme.barWidth : 0)
        width: parent.width - (isHorizontal ? 0 : Theme.barWidth)
        sourceComponent: Widgets {}
    }

    Behavior on color {ColorAnim {}}
    Component.onCompleted: isLoad = true
}