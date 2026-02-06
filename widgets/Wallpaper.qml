import QtQuick
import Quickshell
import Qt.labs.folderlistmodel
import qs.settings

Item {
    property var palit: wallpaperPalit.colors

    anchors.fill: parent

    onPalitChanged: {
        if (!palit || palit.length < 8)
            return
        
        Style.color1 = palit[0]
        Style.color2 = palit[1]
        Style.color3 = palit[2]
        Style.color4 = palit[3]
        Style.color5 = palit[4]
        Style.color6 = palit[5]
        Style.color7 = palit[6]
        Style.color8 = palit[7]
    }

    Connections {
        target: WallpaperListInit
        function onWallpaperReady() {
            const imagesChose = Math.floor(Math.random() * Style.imagesList.length)
            Style.images = Style.imagesList[imagesChose]
        }
    }

    ColorQuantizer {
        source: Qt.resolvedUrl(Style.images)
        id: wallpaperPalit
        depth: 3
        rescaleSize: 64
    }

    Image {
        id: wallpaper
        source: Style.images
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }
}