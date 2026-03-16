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
    anchors {
        left: true
        top: true
        right: true
    }
    implicitHeight: Appearance.barHeight
    color: Colors.surface

    Item {
        anchors.centerIn: parent
        height: parent.height - Appearance.padding.normal
        width: parent.width - Appearance.padding.large - Appearance.padding.normal

        RowNormal {
            anchors.left: parent.left
            height: parent.height

            PowerButton { }
            Workspace { }
            Programs { }
        }

        RowNormal {
            anchors.centerIn: parent
            height: parent.height

            Clock { }
        }

        RowNormal {
            anchors.right: parent.right
            height: parent.height

            ServicesWrapper { }
            ControlCenterButton { }
        }
    }
}