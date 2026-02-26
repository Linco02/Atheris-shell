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
    property int gap: 60

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
                    MouseFill { onClicked: widgetRow.state = "page1" }
                }

                Item {
                    height: 40; width: height

                    TextStyledH {
                        anchors.centerIn: parent
                        text: "󰨝"
                    }
                    MouseFill { onClicked: widgetRow.state = "page2" }
                }

                Item {
                    height: 40; width: height

                    TextStyledH {
                        anchors.centerIn: parent
                        text: ""
                    }
                    MouseFill { onClicked: widgetRow.state = "page3" }
                }
            }
        }

        RectForeground {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 2
            width: widgetRow.width
        }

        Rect {
            id: widgetRow
            anchors.horizontalCenter: parent.horizontalCenter
            height: page1.height; width: page1.width
            clip: true
            state: "page2"

            states: [
                State {
                    name: "page1"
                    PropertyChanges {
                        target: widgetRow
                        height: page1.height; width: page1.width
                    }
                    PropertyChanges { target: pages; x: 0 }
                },
                State {
                    name: "page2"
                    PropertyChanges {
                        target: widgetRow
                        height: page2.height; width: page2.width
                    }
                    PropertyChanges { target: pages; x: - gap - page1.width }
                },
                State {
                    name: "page3"
                    PropertyChanges {
                        target: widgetRow
                        height: page3.height; width: page3.width
                    }
                    PropertyChanges { target: pages; x: - gap * 2 - page1.width - page2.width }
                }
            ]

            transitions: Transition {
                ParallelAnimation {
                    NumberAnim { property: "height"; duration: Appearance.durations.fast }
                    NumberAnim { property: "width"; duration: Appearance.durations.fast }
                    NumberAnim { property: "x" }
                }
            }

            Row {
                id: pages
                spacing: gap
                x: 0
                
                Music { id: page1 }
                Dash { id: page2 }
                Perfomance { id: page3 }
            }
        }
    }

    component MouseFill: MouseArea {
        anchors.fill: parent
    }
}