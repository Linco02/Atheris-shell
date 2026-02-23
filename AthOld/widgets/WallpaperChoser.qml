import QtQuick
import Quickshell
import qs.settings

Rectangle {
    property var palit: []

    onPalitChanged: {
        if (!palit || palit.length < 8)
            return
        
        Style.color1 = palit[0]
        Style.color2 = palit[1]
        Style.color3 = palit[2]
        Style.color4 = palit[3]
        Style.color5 = palit[4]
        Style.color6 = palit[5]
        Style.color7 = palit[6]
        Style.color8 = palit[7]
    }

    id: root
    implicitHeight: 168; implicitWidth: 480

    Connections {
        target: WallpaperListInit
        function onWallpaperReady() {
            for (let i = 0; i < Style.imagesList.length; i ++) {
                wallpaperModel.append({"wallpaperUrl": Style.imagesList[i].toString()})
            }
        }
    }

    ListModel {
        id: wallpaperModel
    }

    Row {
        Repeater {
            model: wallpaperModel
            Item {
                height: root.height; width: root.width / 2

                ColorQuantizer {
                    id: wallpaperPalit
                    source: Qt.resolvedUrl(model.wallpaperUrl)
                    depth: 3
                    rescaleSize: 64
                }

                Image {
                    anchors.top: parent.top
                    height: parent.height; width: parent.width
                    asynchronous: true
                    source: model.wallpaperUrl

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            Style.images = model.wallpaperUrl
                            palit = wallpaperPalit.colors
                        }
                    }
                }

                Rectangle {
                    id: colorsPalit
                    anchors.bottom: parent.bottom
                    height: 40; width: parent.width
                    Row {
                        anchors.centerIn: parent
                        spacing: 5

                        Repeater {
                            model: wallpaperPalit.colors

                            Rectangle {
                                height: colorsPalit.height / 2; width: colorsPalit.height / 2
                                color: wallpaperPalit.colors[index]
                                border.width: 2
                            }

                            onCountChanged: {
                                if (count === 8) {
                                    colorsPalit.color = wallpaperPalit.colors[7]
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}