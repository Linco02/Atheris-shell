import QtQuick
import Quickshell
import qs.config
import qs.services
import qs.components.containers
import qs.components.shapes
import qs.components.animations

RectBackground {
    id: root
    implicitHeight: (box.height + Appearance.padding.gigant) * percent
    implicitWidth: box.width + Appearance.padding.gigant
    border.color: Appearance.outline
    border.width: 2

    signal close()
    property real percent: 0
    property int imageHeight: 135
    property int imageWidth: 240

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
        height: imageHeight; width: imageWidth * 4
        clip: true
        opacity: 0

        RowNormal {
            id: row
            x: - currentIndex * imageWidth - imageWidth / 2 + box.width / 2 - currentIndex * Appearance.padding.normal

            property int currentIndex: 0

            Connections {
                target: Wallpapers
                function onWallpaperReady() {
                    let index = Wallpapers.wallparersList.indexOf(Wallpapers.wallpaper);
                    if (index !== -1)
                        row.currentIndex = index;
                }
            }

            focus: true
            Keys.onLeftPressed: {
                currentIndex = Math.max(0, currentIndex - 1)
                let wallData = wallRepeator.itemAt(currentIndex)
                if (wallData) {
                    Wallpapers.wallpaper = wallData.wallSource
                }
            }

            Keys.onRightPressed: {
                currentIndex = Math.min(children.length - 2, currentIndex + 1)
                let wallData = wallRepeator.itemAt(currentIndex)
                if (wallData) {
                    Wallpapers.wallpaper = wallData.wallSource
                }
            }            

            Behavior on x { NumberAnim { } }

            Repeater {
                id: wallRepeator
                model: wallpaperModel
                Item {
                    height: imageHeight; width: imageWidth
                    scale: index === row.currentIndex ? 1 : 0.8

                    property string wallSource: model.wallpaperUrl

                    Behavior on scale { NumberAnim { } }

                    Image {
                        anchors.fill: parent
                        asynchronous: true
                        source: model.wallpaperUrl
                    }
                }
            }
        }
    }
}