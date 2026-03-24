pragma Singleton
import Quickshell
import Quickshell.Io
import Qt.labs.folderlistmodel

Singleton {
    property var wallparersList: []
    property var wallpaper: ""
    signal wallpaperReady()

    FolderListModel {
        id: listWallpaper
        folder: "file:///home/linco02/Atheris-shell/assets/wallpaper/"
        nameFilters: ["*.jpg", "*.png"]

        onStatusChanged: {
            if (listWallpaper.status == FolderListModel.Ready) {
                for (let i = 0; i < count; i++) {
                    wallparersList.push(get(i, "fileUrl"))
                }
                wallpaperReady()
            }
        }
    }
}