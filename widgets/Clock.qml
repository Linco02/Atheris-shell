import QtQuick
import qs.singletons
import qs.settings
import qs.components

import Quickshell

RectForeground {
    id: clockwidget
    height: panelHeight - Style.padding2x; width: clockText.width + Style.padding * 2

    property string time: ""

    Connections {
        target: Time
        function onDate(data) {
            time = data
        }
    }

    TextStyle2 {
        id: clockText
        anchors.centerIn: parent
        text: time
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: clockwidget.color = Style.activeColor
        onExited: clockwidget.color = Style.foreGround
        onClicked: jumpMenu.openMenu()
    }

    Behavior on color {
        ColorAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    // Menu
    JumpMenu {
        id: jumpMenu
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

                    Item {
                        height: 40; width: height

                        TextStyle2 {
                            anchors.centerIn: parent
                            text: "󰼄"
                        }
                    }
                }
            }

            RectForeground {
                anchors.horizontalCenter: parent.horizontalCenter
                height: 2
                width: parent.width - Style.spacing * 2
            }

            Perfomance {
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}