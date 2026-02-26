import QtQuick
import QtQuick.Controls
import qs.config
import qs.components.animations
import qs.components.containers
import qs.components.shapes
import qs.components

ShapeJump {
    anchor {
        window: root
        rect.x: root.width / 2 - width / 2
        rect.y: root.height
    }
    implicitHeight: 600; implicitWidth: 1000

    property int space: Appearance.spacing.normal

    property int rotate: 180
    containerHeight: controlCenterWidget.height
    containerWidth: controlCenterWidget.width

    Column {
        id: controlCenterWidget
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        spacing: space

        Item {
            id: navigation
            anchors.horizontalCenter: parent.horizontalCenter
            height: switchNavigation.height
            width: switchNavigation.width + space

            Row {
                id: switchNavigation
                anchors.centerIn: parent
                spacing: navigation.height * 3 / 2

                Item {
                    height: 40; width: height

                    TextStyledH {
                        anchors.centerIn: parent
                        text: "󰼄"
                    }
                    MouseFill {
                        onClicked: pages.replace("Music.qml")
                    }
                }

                Item {
                    height: 40; width: height

                    TextStyledH {
                        anchors.centerIn: parent
                        text: "󰨝"
                    }
                    MouseFill {
                        onClicked: pages.replace("Dash.qml")
                    }
                }

                Item {
                    height: 40; width: height

                    TextStyledH {
                        anchors.centerIn: parent
                        text: ""
                    }
                    MouseFill {
                        onClicked: pages.replace("Perfomance.qml")
                    }
                }
            }
        }

        RectForeground {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 2
            width: parent.width - space * 2
        }

        Rect {
            height: pages.height + space; width: pages.width + space * 2

            StackView {
                id: pages
                anchors.horizontalCenter: parent.horizontalCenter
                height: currentItem ? currentItem.implicitHeight : 200
                width: currentItem ? currentItem.implicitWidth : 200
                clip: true
                initialItem: Dash {}
            

                Behavior on height { NumberAnim { duration: Appearance.durations.fast } }
                Behavior on width { NumberAnim {duration: Appearance.durations.fast } }
            }
        }
    }

    component MouseFill: MouseArea {
        anchors.fill: parent
    }
}