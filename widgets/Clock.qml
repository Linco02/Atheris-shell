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
        onClicked: {
            jumpMenu.visible = true
            jumpMenu.percent = 1
            perfomanceWidget.active = true
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    // Menu

    Connections {
        target: jumpMenu

        function onClose() {
            perfomanceWidget.active = false
        }
    }

    JumpMenu {
        id: jumpMenu
        implicitHeight: controlCenterWidget.height;
        implicitWidth: controlCenterWidget.width

        Item {
            id: controlCenterWidget
            height: perfomanceWidget.height + navigation.height; width: perfomanceWidget.width + Style.radius2 * 2

            Rectangle {
                id: navigation
                height: 0; width: parent.weight
                color: "red"

                // Row {
                //     // anchors.centerIn: parent
                //     Rectangle {
                //         height: navigation.height - Style.padding2x; width: height
                //         color: "blue"
                //     }
                // }

            }

            Perfomance {
                id: perfomanceWidget
                property bool active: false
                property real fade: - height
                y: fade

                Behavior on fade {
                    NumberAnimation { duration: Style.spedAnim }
                }

                onActiveChanged: {
                    if(active) {
                        fade = navigation.height
                    } else {
                        fade = - height
                    }
                }
            }
        }
    }
}