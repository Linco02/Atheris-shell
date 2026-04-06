pragma Singleton
import QtQuick
import Qt.labs.folderlistmodel
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.config

Singleton {
    property var wallpapers: []
    property var wallpaperFrameQueue: []
    property string wallpaper: ""
    property string wallpaperFrame: ""
    property bool isWallpaperAnimated: false
    property bool isFrameGenerating: false
    property bool isDesktopEmpty: {
        const activeWs = Hyprland.focusedWorkspace
        if (!activeWs) return true
        return !Hyprland.toplevels.values.some(tl => tl.workspace && tl.workspace.id === activeWs.id)
    }
    property var formatSupported: ({
        "image" : [".png", ".jpg", ".jpeg"],
        "anmf" : [".gif", ".webp"],
        "video" : [".mp4"]
    })

    onWallpaperFrameQueueChanged: {
        if (!isFrameGenerating)
            frameNext();
    }

    function wallpaperInit() {
        if (Global.settings.isRandomWallpaperOn) wallpaperRandom()
        else if (Global.wallpaperCurrent !== "") wallpaperChange(Global.wallpaperCurrent)
    }

    function wallpaperRandom() {
        let index = Math.floor(Math.random() * wallpapers.length)
        let wall = wallpapers[index]
        Global.wallpaperCurrent = wall
        wallpaperChange(wall)
    }

    function wallpaperChange(wall) {
        let path = wall.toString().toLowerCase();
        if (wallpaperFormat(wall) === 1) {
            isWallpaperAnimated = false
            wallpaper = wall
        } else {
            isWallpaperAnimated = true
            wallpaperFrame = wallpaperTempPath(wall)
            wallpaper = wall
        }
    }

    // TODO webp не працює
    function wallpaperFrameGenerate(path) {
        let rawPath = wallpaperRawPath(path)
        let tempPath = wallpaperTempPath(path)
        
        frameGenerate.command = [
            "ffmpeg", "-y",
            "-ss", "00:00:01",
            "-i", rawPath,
            "-vframes", "1",
            "-update", "1",
            tempPath
        ];
        frameGenerate.running = true;
    }

    function frameNext() {
        if (wallpaperFrameQueue.length > 0 && !isFrameGenerating) {
            isFrameGenerating = true
            wallpaperFrameGenerate(wallpaperFrameQueue[0])
            wallpaperFrameQueue.shift();
        }
    }

    function wallpaperFormat(wall) {
        let path = wall.toString().toLowerCase();

        for (const type in formatSupported)
            if (formatSupported[type].some(e => path.endsWith(e))) return type
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

    FolderListModel {
        id: listWallpaper
        folder: "file:///home/linco02/wallpapers/"
        nameFilters: {
            let result = []
            Global.settings.wallpaperFormat.forEach(f => {
                (formatSupported[f] ?? []).forEach(e => result.push("*" + e))
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

            wallpaperFrameQueue = wallAnimList;
            wallpapers = wallList;
            wallpaperInit()
        }

        onStatusChanged: if (listWallpaper.status == FolderListModel.Ready) updateFiles()
        onCountChanged: if (status === FolderListModel.Ready) updateFiles()
    }

    Process {
        id: frameGenerate
        onExited: {
            isFrameGenerating = false;
            frameNext();
        }
    }

    Connections {
        target: Global
        function onWallpaperCurrentChanged() { wallpaperChange(Global.wallpaperCurrent) }
    }
}