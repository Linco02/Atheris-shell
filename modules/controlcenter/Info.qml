import QtQuick
import qs.config
import qs.services
import qs.components.shapes
import qs.components

Item {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter
    height: 26
    width: parent.width - Appearance.padding.large * 2

    Item {
        anchors.fill: parent

        TextStyledH {
            anchors.left: parent.left
            text: "Up 16h25m"
        }

        Row {
            anchors.right: parent.right
            height: root.height
            spacing: 10

            TextStyledH {
                text: "󰂚"
                color: Colors.inactive
                MouseFill {
                    onClicked: {
                        NotifiServis.send("test", "test", "low")
                    }
                }
            }

            TextStyledH {
                text: "󰂚"
                color: Colors.active
                MouseFill {
                    onClicked: {
                        NotifiServis.send("test", "test", "normal")
                    }
                }
            }

            TextStyledH {
                text: "󰂚"
                color: Colors.warning
                MouseFill {
                    onClicked: {
                        NotifiServis.send("test", "test", "critical")
                    }
                }
            }

            TextStyledH {
                text: ""
            }

            TextStyledH {
                text: ""
            }
        }
    }
}