import QtQuick
import QtQuick.Controls
import qs.settings
import qs.components

JumpMenu {
    containerHeight: controlCenterWidget.height
    containerWidth: controlCenterWidget.width

    Column {
        id: controlCenterWidget
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Style.spacing

        Item {
            id: navigation
            anchors.horizontalCenter: parent.horizontalCenter
            height: switchNavigation.height
            width: switchNavigation.width + Style.spacing

            Row {
                id: switchNavigation
                anchors.centerIn: parent
                spacing: navigation.height * 3 / 2

                Item {
                    height: 40; width: height

                    TextStyle2 {
                        anchors.centerIn: parent
                        text: "󰼄"
                    }
                    MouseArea1 {
                        onClicked: pages.replace(mediaPage, StackView.PopTransition)
                    }
                }

                Item {
                    height: 40; width: height

                    TextStyle2 {
                        anchors.centerIn: parent
                        text: "󰨝"
                    }
                    MouseArea1 {
                        onClicked: pages.replace(dashBoaradPage, StackView.PushTransition)
                    }
                }

                Item {
                    height: 40; width: height

                    TextStyle2 {
                        anchors.centerIn: parent
                        text: ""
                    }
                    MouseArea1 {
                        onClicked: pages.replace(perfomancePage, StackView.PushTransition)
                    }
                }
            }
        }

        RectForeground {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 2
            width: parent.width - Style.spacing * 2
        }

        StackView {
            id: pages
            anchors.horizontalCenter: parent.horizontalCenter
            height: currentItem ? currentItem.implicitHeight : 200
            width: currentItem ? currentItem.implicitWidth : 200

            initialItem: dashBoaradPage
        }

        Component {
            id: mediaPage
            Rectangle {
                implicitHeight: 400
                implicitWidth: 300
                color: "blue"
            }
        }

        Component {
            id: dashBoaradPage
            DashBoard { }
        }

        Component {
            id: perfomancePage
            Perfomance { }
        }
    }
}