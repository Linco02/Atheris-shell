import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
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
                id: wallRepeator
                model: wallpaperModel
                RectClip {
                    id: brick
                    height: imageHeight; width: imageWidth
                    border {
                        width: 2
                        color: Colors.inactive
                    }

                    Image {
                        anchors.fill: parent
                        asynchronous: true
                        source: model.wallpaperUrl
                    }

                    MouseFill {
                        hoverEnabled: true
                        onEntered: brick.border.color = Colors.active
                        onExited: brick.border.color = Colors.inactive
                        onClicked: Wallpapers.wallpaper = model.wallpaperUrl
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