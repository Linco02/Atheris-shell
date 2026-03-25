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
    height: imageHeight * rowNum + Appearance.spacing.normal * (rowNum - 1)
    width: imageWidth * colNum + Appearance.spacing.normal * (colNum - 1)

    property int imageHeight: 135
    property int imageWidth: 240
    property int colNum: 4
    property int rowNum: 3

    ListModel {
        id: wallpaperModel
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: -1
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        GridLayout {
            id: wallpaperBox
            columns: colNum
            rowSpacing: Appearance.spacing.normal
            columnSpacing: Appearance.spacing.normal

            Repeater {
                model: wallpaperModel

                RectClip {
                    id: brick
                    height: imageHeight; width: imageWidth
                    border {
                        width: 2
                        color: Colors.inactive
                    }

                    Loader {
                        anchors.fill: parent
                        sourceComponent: {
                            let type = Wallpapers.whatWallpaperFormat(modelData);
                            if (type === "img") return imageComp;
                            if (type === "anmf") return anmfComp;
                            if (type === "video") return videoComp;
                        }
                    }

                    Component {
                        id: imageComp
                        Image {
                            anchors.fill: parent
                            source: modelData
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                        }
                    }

                    Component {
                        id: anmfComp
                        AnimatedImage {
                            anchors.fill: parent
                            source: modelData
                        }
                    }

                    Component {
                        id: videoComp
                        Item {
                            anchors.fill: parent

                            MediaPlayer {
                                id: player
                                source: modelData
                                audioOutput: AudioOutput { muted: true } 
                                loops: MediaPlayer.Infinite
                                videoOutput: videoOutput 
                            }

                            VideoOutput {
                                id: videoOutput
                                anchors.fill: parent
                            }

                            Component.onCompleted: player.play();
                        }
                    }

                    MouseFill {
                        hoverEnabled: true
                        onEntered: brick.border.color = Colors.active
                        onExited: brick.border.color = Colors.inactive
                        onClicked: Wallpapers.wallpaperSelected = model.wallpaperUrl
                    }

                    Behavior on border.color { ColorAnim { } }
                }
            }
        }
    }

    Component.onCompleted: {
        for (let i = 0; i < Wallpapers.wallparersList.length; i ++) {
            wallpaperModel.append({"wallpaperUrl": Wallpapers.wallparersList[i].toString()})
        }
    }
}