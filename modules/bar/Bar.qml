import Quickshell
import QtQuick
import qs.config
import "./components"

PanelWindow {
    id: root
    anchors {
        left: barPosition !== "right"
        right: barPosition !== "left"
        top: barPosition !== "bottom"
        bottom: barPosition !== "top"
    }
    implicitHeight: isHorizontal ? Style.barWidth : (undefined || 0)
    implicitWidth: isHorizontal ? (undefined || 0) : Style.barWidth
    color: Theme.surface

    property string barPosition: Settings.barPosition || "top"
    property bool isHorizontal: (barPosition === "top" || barPosition === "bottom")

    Item {
        anchors {
            verticalCenter: isHorizontal ? parent.verticalCenter : undefined
            horizontalCenter: isHorizontal ? undefined : parent.verticalCenter
        }
        height: root.height - Style.padding.normal
        width: root.width

        RowContainer {
            anchors.left: parent.left
            leftPadding: Style.padding.normal

            Power { }
            Workspace { }
            Taskbar { }
        }

        RowContainer {
            anchors.horizontalCenter: parent.horizontalCenter

            Clock { }
            Music { }
        }

        RowContainer {
            anchors.right: parent.right
            rightPadding: Style.padding.normal

            Status { }
        }
    }

    component RowContainer : Row {
        height: root.height - Style.padding.normal
        spacing: Style.spacing.large
    }
}

// import QtQuick
// import Quickshell
// import Quickshell.Wayland
// import qs.components.shapes
// import qs.components.animations
// import qs.components.containers
// import qs.config
// import qs.modules.session
// import qs.modules.commandcenter
// import qs.modules.controlcenter
// import "./components"
// import "./components/buttons"

// PanelWindow {
//     id: root
//     anchors {
//         left: true
//         top: true
//         right: true
//     }
//     implicitHeight: Global.appearance.barHeight
//     color: "transparent"
//     focusable: Global.isAnythingOpen

//     Item {
//         anchors {
//             horizontalCenter: parent.horizontalCenter
//             bottom: parent.bottom
//         }
//         height: parent.height; width: parent.width

//         RectBackground {
//             anchors.fill: parent
//             radius: 0
//         }

//         RowOwn {
//             anchors.left: parent.left
//             leftPadding: Global.padding.normal

//             PowerButton { }
//             Workspace { }
//             Taskbar { }
//         }

//         RowOwn {
//             anchors.horizontalCenter: parent.horizontalCenter

//             Clock { }
//             Music { }
//         }

//         RowOwn {
//             anchors.right: parent.right
//             rightPadding: Global.padding.normal

//             Status { }
//         }
//     }

//     Loader {
//         sourceComponent: Power { panel: root }
//     }

//     Loader {
//         sourceComponent: CommandCenter { panel: root }
//     }

//     Loader {
//         sourceComponent: ControlCenter { panel: root }
//     }

//     component RowOwn : SpacedRow {
//         anchors.verticalCenter: parent.verticalCenter
//         height: root.height - Global.padding.normal
//     }
// }