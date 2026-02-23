import QtQuick
import Quickshell
import qs.config
import qs.services

Item {
    property var palit: wallpaperPalit.colors

    onPalitChanged: {
        if (!palit || palit.length < 8)
            return
        
        Appearance.base = palit[0]
        Appearance.mantle = palit[1]
        Appearance.overlay = palit[2]
        Appearance.muted = palit[3]
        Appearance.subtle = palit[4]
        Appearance.accent = palit[5]
        Appearance.highlight = palit[6]
        Appearance.rose = palit[7]
    }

    Connections {
        target: Wallpapers
        function onWallpaperReady() {
            const imagesChose = Math.floor(Math.random() * Wallpapers.wallparersList.length)
            Appearance.wallpaper = Wallpapers.wallparersList[imagesChose]
        }
    }

    ColorQuantizer {
        source: Qt.resolvedUrl(Appearance.wallpaper)
        id: wallpaperPalit
        depth: 3
        rescaleSize: 64
    }
}