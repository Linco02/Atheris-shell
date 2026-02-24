import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.config
import qs.components.shapes
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

    RectBackground {
        id: exitBox
        anchors.centerIn: parent
        height: 200; width: exitRow.width + height / 2
        border {
            color: Appearance.outline
            width: 2
        }

        Row {
            id: exitRow
            anchors.centerIn: parent
            spacing: exitBox.height / 4
            RectOwn {
                TextOwn { text: "" }

                MouseFill {
                    onClicked: poweroffProcess.running = true
                }
            }

            RectOwn {
                TextOwn { text: "" }

                MouseFill {
                    onClicked: rebootProcess.running = true
                }
            }

            RectOwn {
                TextOwn { text: "󰤄" }

                MouseFill {
                    onClicked: suspendProcess.running = true
                }
            }

            RectOwn {
                TextOwn { text: "󰚭" }

                MouseFill {
                    onClicked: hibernateProcess.running = true
                }
            }
        }
    }

    component RectOwn: RectForeground {
        height: exitBox.height / 2; width: height
    }

    component TextOwn: TextStyled {
        anchors.centerIn: parent
        font.pointSize: 60
    }

    component MouseFill: MouseArea {
        anchors.fill: parent
    }
}