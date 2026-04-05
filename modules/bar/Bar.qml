import QtQuick
import Quickshell
import qs.components.shapes
import qs.components.animations
import qs.components.containers
import qs.config
import qs.modules.dashboard
import "./components"
import "./components/buttons"

PanelWindow {
    id: root
    anchors {
        left: true
        top: true
        right: true
    }
    implicitHeight: Global.appearance.barHeight
    color: "transparent"

    Item {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
        }
        height: parent.height; width: parent.width

        RectBackground {
            anchors.fill: parent
            radius: 0
        }

        RowOwn {
            anchors.left: parent.left
            leftPadding: Global.padding.normal

            PowerButton { }
            Workspace { }
            Taskbar { }
        }

        RowOwn {
            anchors.horizontalCenter: parent.horizontalCenter

            Clock { }
            Music { }
        }

        RowOwn {
            anchors.right: parent.right
            rightPadding: Global.padding.normal

            Battery { }
            Sound { }
            Network { }
            Language { }
            ControlCenterButton { }
        }
    }

    Loader {
        active: true
        sourceComponent: DashBoard {
            panel: root
        }
    }

    component RowOwn : SpacedRow {
        anchors.verticalCenter: parent.verticalCenter
        height: root.height - Global.padding.normal
    }
}