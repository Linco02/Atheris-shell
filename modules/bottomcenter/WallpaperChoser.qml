import QtQuick
import Quickshell
import qs.config
import qs.services
import qs.components.containers
import qs.components.shapes
import qs.components.animations

RectBackground {
    id: root
    anchors.centerIn: parent
    implicitHeight: (box.height + Appearance.padding.gigant) * percent
    implicitWidth: box.width + Appearance.padding.gigant
    border.color: Appearance.outline
    border.width: 2

    signal close()
    property real percent: 0

    states: State {
        name: "open"
        PropertyChanges {
            target: root
            percent: 1
        }
        PropertyChanges {
            target: box
            opacity: 1
        }
    }

    transitions: [
        Transition {
            from: ""; to: "open"
            SequentialAnimation {
                PropertyAnim {
                    property: "percent"
                }
                PropertyAnim {
                    property: "opacity"
                    duration: Appearance.durations.fast
                }
            }
            
        },
        Transition {
            from: "open"; to: ""
            SequentialAnimation {
                PropertyAnim {
                    property: "opacity"
                    duration: Appearance.durations.fast
                }
                PropertyAnim {
                    property: "percent"
                }
                ScriptAction {
                    script: close()
                }
            }

        }
    ]

    Timer {
        id: timerClose
        interval: 300
        onTriggered: {
            root.state = ""
        }
    }

    function palitPush(palit) {
        Appearance.base = palit[0]
        Appearance.mantle = palit[1]
        Appearance.overlay = palit[2]
        Appearance.muted = palit[3]
        Appearance.subtle = palit[4]
        Appearance.accent = palit[5]
        Appearance.highlight = palit[6]
        Appearance.rose = palit[7]
    }

    Connections {
        target: Wallpapers
        function onWallpaperReady() {
            for (let i = 0; i < Wallpapers.wallparersList.length; i ++) {
                wallpaperModel.append({"wallpaperUrl": Wallpapers.wallparersList[i].toString()})
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            timerClose.stop()
            root.state = "open"
        }
        onExited: {
            timerClose.start()
        }
    }

    ListModel {
        id: wallpaperModel
    }

    Item {
        id: box
        anchors.centerIn: parent
        height: 168; width: 900
        clip: true
        opacity: 0

        RowNormal {
            id: row
            x: - currentIndex * 240 - 120 + box.width / 2 - currentIndex * Appearance.padding.normal

            property int currentIndex: 0

            Connections {
                target: Wallpapers
                function onWallpaperReady() {
                    let index = Wallpapers.wallparersList.indexOf(Appearance.wallpaper);
                    if (index !== -1)
                        row.currentIndex = index;
                }
            }

            focus: true
            Keys.onLeftPressed: {
                currentIndex = Math.max(0, currentIndex - 1)
                let wallData = wallRepeator.itemAt(currentIndex)
                if (wallData) {
                    palitPush(wallData.paletteColors)
                    Appearance.wallpaper = wallData.wallSource
                }
            }

            Keys.onRightPressed: {
                currentIndex = Math.min(children.length - 2, currentIndex + 1)
                let wallData = wallRepeator.itemAt(currentIndex)
                if (wallData) {
                    palitPush(wallData.paletteColors)
                    Appearance.wallpaper = wallData.wallSource
                }
            }            

            Behavior on x { NumberAnim { } }

            Repeater {
                id: wallRepeator
                model: wallpaperModel
                Item {
                    height: 168; width: 240
                    scale: index === row.currentIndex ? 1 : 0.8

                    property var paletteColors: wallpaperPalit.colors
                    property string wallSource: model.wallpaperUrl

                    Behavior on scale { NumberAnim { } }

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
}