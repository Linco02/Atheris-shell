import QtQuick
import Quickshell
import qs.config
import qs.components.animations
import qs.components.containers
import qs.modules.dashboard
import qs.modules.controlcenter
import "./components"

PanelWindow {
    id: root

    property int padd: Appearance.padding.normal

    anchors {
        left: true
        top: true
        right: true
        // bottom: true
    }
    implicitHeight: Appearance.barHeight
    color: Colors.surface


    Item {
        anchors.fill: parent

        Item {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            height: root.height - padd * 2; width: leftTBRow.width

            RowNormal {
                id: leftTBRow
                anchors.verticalCenter: parent.verticalCenter
                x: padd

                PowerButton { }
                Workspace { }
                Programs { }
            }
        }

        Item {
            anchors.centerIn: parent
            height: root.height - padd * 2; width: centerTBRow.width

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
            height: root.height - padd * 2; width: rightTBRow.width
                
            RowNormal {
                id: rightTBRow
                anchors.verticalCenter: parent.verticalCenter
                x: - padd

                ServicesWrapper { }
                ControlCenterButton { }
            }
        }
    }
}