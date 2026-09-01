import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import QtMultimedia
import qs.config
import qs.services
import qs.components
import qs.components.containers
import qs.components.shapes
import qs.components.animations

Item {
    height: imageHeight * rowNum + Style.spacing.normal * (rowNum - 1)
    width: imageWidth * colNum + Style.spacing.normal * (colNum - 1)

    property int imageHeight: 135
    property int imageWidth: 240
    property int colNum: 4
    property int rowNum: 3

    MediaPlayer {
        id: player
        loops: MediaPlayer.Infinite
    }

    ScrollStyled {
        anchors.fill: parent

        GridLayout {
            id: wallpaperBox
            columns: colNum
            rowSpacing: Style.spacing.normal
            columnSpacing: Style.spacing.normal

            Repeater {
                model: SWallpaper.wallpapers

                RectClip {
                    id: brick
                    height: imageHeight; width: imageWidth
                    border {
                        width: 2
                        color: hover.hovered ? Theme.active : Theme.inactive

                        Behavior on color { ColorAnim { } }
                    }

                    property string type: SMedia.toFormat(modelData)

                    Item {
                        anchors.fill: parent
                        OwnImage { source: type === "image" ? modelData : SMedia.toThumbnailPath(modelData)}
                        OwnText { text: type === "image" ? "" : type === "anmf" ? "󰪐" : "" }
                    }

                    Loader {
                        id: loaderComponent
                        anchors.fill: parent
                        active: type !== "image"
                        sourceComponent: {
                            if (type === "anmf") return anmfComp;
                            if (type === "video") return videoComp;
                        }
                    }

                    Component {
                        id: anmfComp
                        AnimatedImage {
                            id: anmf
                            anchors.fill: parent
                            source: modelData
                            playing: hover.hovered ? true : false
                        }
                    }

                    Component {
                        id: videoComp
                        VideoOutput {
                            id: videoOutput
                            anchors.fill: parent
                            fillMode: VideoOutput.PreserveAspectCrop

                            property alias videoSurface: videoOutput

                            Connections {
                                target: hover
                                function onHoveredChanged() {
                                    if (hover.hovered) {
                                        player.stop()
                                        player.source = modelData
                                        player.videoOutput = loaderComponent.item.videoSurface
                                        player.play()
                                    } else {
                                        player.stop()
                                        player.videoOutput = null
                                    }
                                }
                            }
                        }
                    }

                    HoverHandler { id: hover }
                    TapHandler {
                        onTapped: {
                            const wall = SMedia.toRawPath(modelData)
                            SWallpaper.wallpaperChange(modelData)
                        }
                    }
                }
            }
        }
    }

    component OwnImage: Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }

    component OwnText: TextStyled {
        y: 5; x: 5
        color: Theme.active
        font.pixelSize: 10
    }
}