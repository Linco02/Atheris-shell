import QtQuick
import Quickshell
import qs.components.shapes
import qs.components.animations
import qs.components.containers
import qs.config
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

    component RowOwn : SpacedRow {
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height - Global.padding.normal
    }
}