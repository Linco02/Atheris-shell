pragma Singleton
import QtQuick
import Qt.labs.folderlistmodel
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.config

Singleton {
    property var wallpapers: []
    property string wallpaper: ""
    property string wallpaperThumbnail: ""
    property bool isWallpaperAnimated: false
    property bool isFrameGenerating: false
    property bool isDesktopEmpty: {
        const activeWs = Hyprland.focusedWorkspace
        if (!activeWs) return true
        return !Hyprland.toplevels.values.some(tl => tl.workspace && tl.workspace.id === activeWs.id)
    }

    function wallpaperInit() {
        if (!Settings.isWallpaperOn) return

        if (Settings.isRandomWallpaperOn) {
            const currentWallpaper = wallpaper.toString()
            let isWallExist = wallpapers.some(w => w.toString() === currentWallpaper)

            if (isWallExist) return
        }

        wallpaperRandom()
    }

    function wallpaperRandom() {
        let index = Math.floor(Math.random() * wallpapers.length)
        let wall = wallpapers[index]
        wallpaperChange(wall)
    }

    function wallpaperChange(wall) {
        let path = wall.toString().toLowerCase();
        let pathPalit = ""

        if (SMedia.toFormat(wall) === "image") {
            isWallpaperAnimated = false

            pathPalit = wall
        } else {
            isWallpaperAnimated = true
            const wallTumb = SMedia.toThumbnailPath(wall)
            
            wallpaperThumbnail = wallTumb
            pathPalit = wallTumb
        }

        if (wallpaper)
            SNotification.nitifiSend("Wallpaper", "Змінено шпалери", SFiles.toName(wall), "preferences-desktop-wallpaper", "normal", 5000, 0)


        SPalit.palitCreate(pathPalit)
        wallpaper = wall
    }

    FolderListModel {
        id: listWallpaper
        folder: "file:///home/linco02/wallpapers/"
        nameFilters: {
            let result = []
            Settings.wallpaperFormat.forEach(f => {
                (SMedia.format[f] ?? []).forEach(e => result.push("*" + e))
            })
            return result
        }

        function updateFiles() {
            const wallList = [];
            const wallAnimList = [];

            for (let i = 0; i < count; i++) {
                let path = get(i, "fileUrl");

                wallList.push(path);

                let p = path.toString().toLowerCase();
                if (p.endsWith(".mp4") || p.endsWith(".gif")) {
                    wallAnimList.push(path);
                };
            };

            SMedia.makeThunbnail(wallAnimList)

            wallpapers = wallList;
            wallpaperInit()
        }

        onStatusChanged: if (listWallpaper.status == FolderListModel.Ready) updateFiles()
        onCountChanged: if (status === FolderListModel.Ready) updateFiles()
    }
}