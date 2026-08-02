pragma Singleton

Singleton {
    property var thumbnailQueue: [ ]
    property bool isThumbnailGenerating: false

    onThumbnailQueueChanged: {
        if (!isFrameGenerating)
            frameNext();
    }

    function toRawPath(path) {
        return path.toString().replace("file://", "");
    }

    function toThumbnailPath(path) {
        let rawPath = toRawPath(path)
        let fileName = rawPath.split('/').pop().replace(/\.[^/.]+$/, "");
        let tempPath = "/tmp/atheris/" + fileName + ".png";
        return tempPath
    }

    property var formatSupported: ({
        "image" : [".png", ".jpg", ".jpeg"],
        "anmf" : [".gif"],
        "video" : [".mp4"]
    })

    function format(media) {
        let path = media.toString().toLowerCase();

        for (const type in formatSupported)
            if (formatSupported[type].some(e => path.endsWith(e))) return type
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