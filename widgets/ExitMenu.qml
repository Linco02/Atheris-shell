import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.settings
import qs.components

PanelWindow {
    anchors {
        top: true
        left: true
        bottom: true
        right: true
    }
    WlrLayershell.layer: WlrLayer.Overlay
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        onClicked: exitMenuLoader.active = false
    }

    Item {
        Process {
            id: poweroffProcess
            command: ["systemctl", "poweroff"]
        }

        Process {
            id: rebootProcess
            command: ["systemctl", "reboot"]
        }

        Process {
            id: suspendProcess
            command: ["systemctl", "suspend"]
        }

        Process {
            id: hibernateProcess
            command: ["systemctl", "hibernate"]
        }   
    }

    RectForeground {
        id: exitBox
        anchors.centerIn: parent
        height: 200; width: exitRow.width + height / 2
        border {
            color: Style.borderColor
            width: 2
        }

        Row {
            id: exitRow
            anchors.centerIn: parent
            spacing: exitBox.height / 4
            RectBackground {
                height: exitBox.height / 2; width: height

                TextStyle1 {
                    anchors.centerIn: parent
                    text: ""
                    font.pointSize: 60
                }

                MouseArea1 {
                    onClicked: poweroffProcess.running = true
                }
            }

            RectBackground {
                height: exitBox.height / 2; width: height

                TextStyle1 {
                    anchors.centerIn: parent
                    text: ""
                    font.pointSize: 60
                }

                MouseArea1 {
                    onClicked: rebootProcess.running = true
                }
            }

            RectBackground {
                height: exitBox.height / 2; width: height

                TextStyle1 {
                    anchors.centerIn: parent
                    text: "󰤄"
                    font.pointSize: 60
                }

                MouseArea1 {
                    onClicked: suspendProcess.running = true
                }
            }

            RectBackground {
                height: exitBox.height / 2; width: height

                TextStyle1 {
                    anchors.centerIn: parent
                    text: "󰚭"
                    font.pointSize: 60
                }

                MouseArea1 {
                    onClicked: hibernateProcess.running = true
                }
            }
        }
    }
}