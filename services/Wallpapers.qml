pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Qt.labs.folderlistmodel

Singleton {
    signal wallpaperReady()
    property var wallparersList: []

    property string wallpaperSelected: ""
    property string wallpaper: ""
    property string wallpaperPlugMpw: ""
    property bool isWallpaperMpw: false

    property var wallIntoImage: []
    property bool iswallIntoImageActive: false

    onWallpaperSelectedChanged: {
        let path = wallpaperSelected.toString().toLowerCase();
        if (path.endsWith(".gif") || path.endsWith(".webp") || path.endsWith(".mp4")) {
            let data = makePictureMpwPath(path)
            isWallpaperMpw = true
            wallpaperPlugMpw = data.temp
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

    function whatWallpaperFormat(wall) {
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
            console.log("wallpaper uknown format", path)
            return ""
        }
    }

    function makePictureMpwPath(path) {
        let rawPath = path.toString().replace("file://", "");
        let fileName = rawPath.split('/').pop().replace(/\.[^/.]+$/, "");
        let tempPath = "/tmp/atheris/" + fileName + ".png";
        return {raw: rawPath, temp: tempPath}
    }

    // TODO webp не працює
    function makePictureFromMpw(path) {
        let data = makePictureMpwPath(path)
        let rawPath = data.raw
        let tempPath = data.temp
        
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

    Process {
        id: makePicture
        onExited: {
            iswallIntoImageActive = false;
            queueNext();
        }
    }

    FolderListModel {
        id: listWallpaper
        folder: "file:///home/linco02/Atheris-shell/assets/wallpaper/"
        nameFilters: ["*.jpg", ".jpeg", "*.png", "*.mp4", "*.gif", "*.webp"]

        function updateFiles() {
            const list = [];

            for (let i = 0; i < count; i++) {
                let path = get(i, "fileUrl");

                list.push(path);

                let p = path.toString().toLowerCase();
                if (p.endsWith(".mp4") || p.endsWith(".gif")) {
                    wallIntoImage.push(path);
                };
            };

            wallparersList = list;
            queueNext();
            wallpaperReady();
        }

        onStatusChanged: {
            if (listWallpaper.status == FolderListModel.Ready) { updateFiles(); }
        }
        
        onCountChanged: {
            if (status === FolderListModel.Ready) { updateFiles(); }
        }
    }
}