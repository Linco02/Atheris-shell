import QtQuick
import Quickshell
import qs.config
import qs.components.containers
import "./components"

PanelWindow {
    id: root

    property real padding: Appearance.padding.normal

    anchors {
        left: true
        top: true
        right: true
    }
    implicitHeight: Appearance.barHeight
    color: Appearance.surface


    Item {
        anchors.fill: parent

        Item {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            height: root.height - padding * 2; width: leftTBRow.width

            RowNormal {
                id: leftTBRow
                anchors.verticalCenter: parent.verticalCenter
                x: 10

                PowerButton { }
                Workspace { }
                Programs { }
            }
        }

        Item {
            anchors.centerIn: parent
            height: root.height - padding * 2; width: centerTBRow.width

            RowNormal {
                id: centerTBRow
                anchors.centerIn: parent

                Clock { }
            }
        }

        Item {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            height: root.height - padding * 2; width: rightTBRow.width
                
            RowNormal {
                id: rightTBRow
                anchors.verticalCenter: parent.verticalCenter
                x: -10

                ServicesWrapper { }
            }
        }
    }
}