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
                    // MouseArea1 {
                    //     onClicked: pages.push()
                    // }
                }

                Item {
                    height: 40; width: height

                    TextStyle2 {
                        anchors.centerIn: parent
                        text: "󰨝"
                    }
                }

                Item {
                    height: 40; width: height

                    TextStyle2 {
                        anchors.centerIn: parent
                        text: ""
                    }
                }
            }
        }

        RectForeground {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 2
            width: parent.width - Style.spacing * 2
        }

        // StackView {
        //     id: pages
        //     height: perfomanceWidget.height; width: perfomanceWidget.width

        //     initialItem: Perfomance {
        //         id: perfomanceWidget
        //         anchors.horizontalCenter: parent.horizontalCenter
        //     }
        // }

        Perfomance {
            id: perfomanceWidget
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}