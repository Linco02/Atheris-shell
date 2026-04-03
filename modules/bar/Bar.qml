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
    }

    component RowOwn : SpacedRow {
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height - Global.padding.normal
    }

    // Item {
    //     anchors.centerIn: parent
    //     height: parent.height - Global.padding.normal
    //     width: parent.width - Global.padding.large - Global.padding.normal

    //     RowNormal {
    //         anchors.left: parent.left
    //         height: parent.height

    //         PowerButton { }
    //         Workspace { }
    //         Taskbar { }
    //     }

    //     RowNormal {
    //         anchors.centerIn: parent
    //         height: parent.height

    //         Clock { }
    //     }

    //     RowNormal {
    //         anchors.right: parent.right
    //         height: parent.height

    //         Music { }
    //         ServicesWrapper { }
    //         ControlCenterButton {
    //             panelWind: root
    //             panelH: root.height
    //             panelW: root.width
    //         }
    //     }
    // }
}