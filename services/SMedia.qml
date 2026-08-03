pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property var thumbnailQueue: []
    property bool isThumbnailGenerating: false
    readonly property var format: ({
        "image" : [".png", ".jpg", ".jpeg"],
        "anmf" : [".gif"],
        "video" : [".mp4"]
    })

    onThumbnailQueueChanged: {
        if (!isThumbnailGenerating)
            nextThumbnail();
    }

    function toRawPath(path) {
        return path.toString().replace("file://", "");
    }

    function toThumbnailPath(path) {
        let rawPath = toRawPath(path)
        let fileName = rawPath.split('/').pop().replace(/\.[^/.]+$/, "");
        let tempPath = "/tmp/atheris/wallpaperThumbnail/" + fileName + ".png";
        return tempPath
    }

    function toFormat(media) {
        let path = media.toString().toLowerCase();

        for (const type in format)
            if (format[type].some(e => path.endsWith(e))) return type
    }

    function makeThunbnail(data) {
        if (!data || data.length ===0) return
        thumbnailQueue = [...thumbnailQueue, ...data];
    }

    function generateThumbnail(path) {
        let rawPath = toRawPath(path)
        let tempPath = toThumbnailPath(path)
        
        thumbnailProcess.command = [
            "ffmpeg", "-y",
            "-ss", "00:00:01",
            "-i", rawPath,
            "-vframes", "1",
            "-update", "1",
            tempPath
        ];
        thumbnailProcess.running = true;
    }

    function nextThumbnail() {
        if (thumbnailQueue.length > 0 && !isThumbnailGenerating) {
            isThumbnailGenerating = true
            generateThumbnail(thumbnailQueue[0])
            thumbnailQueue.shift();
        }
    }

    Process {
        id: thumbnailProcess
        onExited: (exitCode, exitStatus) => {
            isThumbnailGenerating = false;

            if (exitCode === 0) {
                nextThumbnail();
            } else {
                console.warn("Frame generation failed with exit code:", exitCode);
                nextThumbnail();
            }
        }
    }
}