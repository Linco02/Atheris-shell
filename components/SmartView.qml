import QtQuick
import QtMultimedia
import qs.services

Item {
    id: root

    property bool isPlay: false
    property string content: ""

    signal contentReady()

    Loader {
        anchors.fill: parent
        sourceComponent: {
            let type = WallpaperService.wallpaperFormat(content);
            if (type === "image") return imageComp;
            if (type === "anmf") return anmfComp;
            if (type === "video") return videoComp;
            return null
        }
    }

    // Зображення
    Component {
        id: imageComp

        Image {
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            source: content
            onStatusChanged: {
                if (status === Image.Ready) contentReady()
            }
        }
    }

    // Анімовані зображення
    Component {
        id: anmfComp

        AnimatedImage {
            anchors.fill: parent
            source: content
            playing: isPlay

            property int frame: 0
            onPlayingChanged: {
                if (!playing)
                    frame = currentFrame
                else
                    currentFrame = frame
            }
            onStatusChanged: {
                if (status === AnimatedImage.Ready) contentReady()
            }
        }
    }

    // Відео
    Component {
        id: videoComp

        Item {
            anchors.fill: parent

            function videoControler() {
                if (isPlay) player.play()
                else player.pause()
            }

            MediaPlayer {
                id: player
                source: content
                loops: MediaPlayer.Infinite
                videoOutput: videoOutput
                Component.onCompleted: videoControler()
            }

            VideoOutput {
                id: videoOutput
                anchors.fill: parent
                fillMode: VideoOutput.PreserveAspectCrop
                onSourceRectChanged: contentReady()
            }

            Connections {
                target: root
                function onIsPlayChanged() { videoControler() }
            }
        }
    }
}