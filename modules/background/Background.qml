import Quickshell
import Quickshell.Wayland
import qs.config
// import qs.services

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
    // color: Appearance.colors.surface

    // function wallpaperOnStartup() {
    //     if (GlobalStates.isRandomWallpaperOn && Wallpapers.wallpaper === "" && Wallpapers.wallparersList.length > 0)
    //         Wallpapers.wallpaperRandom()
    //     else if (!GlobalStates.isRandomWallpaperOn && Wallpapers.wallpaperCurrent !== "")
    //         Wallpapers.wallpaperSelected = GlobalStates.wallpaperCurrent
    //     else
    //         NotifiServis.send("Wallpaper", "Wallpaper не може ініціалізуватися(background/Background)", "critical")
    // }

    // Loader {
    //     active: GlobalStates.isWallpaperOn
    //     anchors.fill: parent
    //     sourceComponent: Component {
    //         Wallpaper {}
    //     }
    // }

    // Connections {
    //     target: Wallpapers
    //     function onWallpaperReady() { wallpaperOnStartup() }
    // }

    // Component.onCompleted: { wallpaperOnStartup() }
}