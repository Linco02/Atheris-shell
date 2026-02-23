pragma Singleton
import Quickshell
import Qt.labs.folderlistmodel

Singleton {
    property var wallparersList: []
    signal wallpaperReady()

    FolderListModel {
        id: listWallpaper
        folder: "file:///home/linco02/Atheris/assets/wallpaper/"
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