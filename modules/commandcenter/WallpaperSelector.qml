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
    height: imageHeight * rowNum + Global.spacing.normal * (rowNum - 1)
    width: imageWidth * colNum + Global.spacing.normal * (colNum - 1)

    property int imageHeight: 135
    property int imageWidth: 240
    property int colNum: 4
    property int rowNum: 3

    MediaPlayer {
        id: player
        loops: MediaPlayer.Infinite
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: -1
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        GridLayout {
            id: wallpaperBox
            columns: colNum
            rowSpacing: Global.spacing.normal
            columnSpacing: Global.spacing.normal

            Repeater {
                model: WallpaperService.wallpapers

                RectClip {
                    id: brick
                    height: imageHeight; width: imageWidth
                    border {
                        width: 2
                        color: hover.hovered ? Colors.active : Colors.inactive

                        Behavior on color { ColorAnim { } }
                    }

                    property string type: WallpaperService.wallpaperFormat(modelData)

                    Item {
                        anchors.fill: parent
                        OwnImage { source: type === "image" ? modelData : WallpaperService.wallpaperTempPath(modelData)}
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
                    TapHandler { onTapped: Global.wallpaperCurrent = modelData }
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
        color: Colors.active
        font.pixelSize: 10
    }
}