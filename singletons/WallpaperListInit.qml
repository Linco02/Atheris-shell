pragma Singleton
import QtQuick
import Qt.labs.folderlistmodel
import qs.settings

Item {
    signal wallpaperReady()

    FolderListModel {
        id: listWallpaper
        folder: "file:///home/linco02/Atheris/assets/wallpaper/"
        nameFilters: ["*.jpg", "*.png"]

        onStatusChanged: {
            if (listWallpaper.status == FolderListModel.Ready) {
                for (let i = 0; i < count; i++) {
                    Style.imagesList.push(get(i, "fileUrl"))
                }
                wallpaperReady()
            }
        }
    }
}