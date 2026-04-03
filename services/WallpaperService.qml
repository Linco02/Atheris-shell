pragma Singleton
import QtQuick
import Qt.labs.folderlistmodel
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.config

Singleton {
    property var wallparersList: []
    property string wallpaperSelected: ""
    property string wallpaper: ""
    property string wallpaperPlugMpw: ""
    property bool isWallpaperMpw: false
    property var wallIntoImage: []
    property bool iswallIntoImageActive: false
    property bool isWallPlay: {
        const activeWs = Hyprland.focusedWorkspace

        if (!activeWs) return true
        
        return !Hyprland.toplevels.values.some(tl => tl.workspace && tl.workspace.id === activeWs.id)
    }

    signal wallpaperReady()

    function wallpaperOnStartup() {
        if (Global.settings.isRandomWallpaperOn && wallparersList.length > 0)
            wallpaperRandom()
        else if (Global.wallpaperCurrent !== "")
            wallpaperSelected = Global.wallpaperCurrent
        else
            NotifiServis.send("Wallpaper", "Wallpaper не може ініціалізуватися(background/Background)", "critical")
        wallpaperChange()
    }

    function wallpaperChange() {
        let path = wallpaperSelected.toString().toLowerCase();
        if (path.endsWith(".gif") || path.endsWith(".webp") || path.endsWith(".mp4")) {
            isWallpaperMpw = true
            wallpaperPlugMpw = wallpaperTempPath(wallpaperSelected)
            wallpaper = wallpaperSelected
        } else {
            isWallpaperMpw = false
            wallpaper = wallpaperSelected
        }
    }

    function wallpaperRandom() {
        const imagesChose = Math.floor(Math.random() * wallparersList.length)
        wallpaperSelected = wallparersList[imagesChose]
    }

    function queueNext() {
        if (wallIntoImage.length > 0 && !iswallIntoImageActive) {
            iswallIntoImageActive = true
            makePictureFromMpw(wallIntoImage[0])
            wallIntoImage.shift();
        }
    }

    function wallpaperFormat(wall) {
        let path = wall.toString().toLowerCase();

        if (path.endsWith(".png") || path.endsWith(".jpg") || path.endsWith(".jpeg")) {
            return "img";
        } else if (path.endsWith(".gif") || path.endsWith(".webp")) {
            return "anmf"
        } else if (path.endsWith(".mp4")) {
            return "video"
        } else if (path === "") {
            return ""
        } else {
            console.log("services/Wallpapers", "wallpaper uknown format", path)
            return ""
        }
    }

    function wallpaperRawPath(path) {
        return path.toString().replace("file://", "");
    }

    function wallpaperTempPath(path) {
        let rawPath = wallpaperRawPath(path)
        let fileName = rawPath.split('/').pop().replace(/\.[^/.]+$/, "");
        let tempPath = "/tmp/atheris/" + fileName + ".png";
        return tempPath
    }

    // TODO webp не працює
    function makePictureFromMpw(path) {
        let rawPath = wallpaperRawPath(path)
        let tempPath = wallpaperTempPath(path)
        
        makePicture.command = [
            "ffmpeg", "-y",
            "-ss", "00:00:01",
            "-i", rawPath,
            "-vframes", "1",
            "-update", "1",
            tempPath
        ];
        makePicture.running = true;
    }

    FolderListModel {
        id: listWallpaper
        folder: "file:///home/linco02/wallpapers/"
        nameFilters: ["*.jpg", ".jpeg", "*.png", "*.mp4", "*.gif", "*.webp"]

        function updateFiles() {
            const list = [];
            const listMpw = [];

            for (let i = 0; i < count; i++) {
                let path = get(i, "fileUrl");

                list.push(path);

                let p = path.toString().toLowerCase();
                if (p.endsWith(".mp4") || p.endsWith(".gif")) {
                    listMpw.push(path);
                };
            };

            wallIntoImage = listMpw;
            wallparersList = list;
            queueNext();
            wallpaperReady();
            wallpaperOnStartup();
        }

        onStatusChanged: {
            if (listWallpaper.status == FolderListModel.Ready) { updateFiles(); }
        }
        
        onCountChanged: {
            if (status === FolderListModel.Ready) { updateFiles(); }
        }
    }

    Process {
        id: makePicture
        onExited: {
            iswallIntoImageActive = false;
            queueNext();
        }
    }

    Connections {
        target: Global
        function onWallpaperCurrentChanged() { wallpaperChange() }
    }
}