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
                        color: Colors.inactive
                    }

                    property string type: WallpaperService.wallpaperFormat(modelData)

                    Loader {
                        id: loaderComponent
                        anchors.fill: parent
                        sourceComponent: {
                            if (type === "image") return imageComp;
                            if (type === "anmf") return anmfComp;
                            if (type === "video") return videoComp;
                        }
                    }

                    Component {
                        id: imageComp
                        Item {
                            anchors.fill: parent
                            OwnImage { source: modelData }
                            OwnText { text: "" }
                        }
                    }

                    Component {
                        id: anmfComp
                        Item {
                            AnimatedImage {
                                anchors.fill: parent
                                source: modelData
                            }
                            OwnText { text: "󰪐" }
                        }
                    }

                    Component {
                        id: videoComp
                        Item {
                            property alias videoSurface: videoOutput

                            OwnImage { source: WallpaperService.wallpaperTempPath(modelData) }
                            VideoOutput {
                                id: videoOutput
                                anchors.fill: parent
                                fillMode: VideoOutput.PreserveAspectCrop
                            }
                            OwnText { text: "" }
                        }
                    }

                    MouseFill {
                        hoverEnabled: true
                        onEntered: {
                            brick.border.color = Colors.active

                            if (type === "video") {
                                player.stop()
                                player.source = modelData
                                player.videoOutput = loaderComponent.item.videoSurface
                                player.play()
                            }
                        }
                        onExited: {
                            brick.border.color = Colors.inactive

                            if (type === "video") {
                                player.stop()
                                player.videoOutput = null
                            }
                        }
                        onClicked: Global.wallpaperCurrent = modelData
                    }

                    Behavior on border.color { ColorAnim { } }
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