import QtQuick
import Quickshell
import qs.singles
import qs.widgets

ShellRoot {
    LazyLoader {
        active: Sett.enableTopPanel
        component: Panel { property int ancorSide: Panel.PanelSide.Top }
    }
    LazyLoader {
        active: Sett.enableBottomPanel
        component: Panel { property int ancorSide: Panel.PanelSide.Bottom }
    }
    LazyLoader {
        active: Sett.enableLeftPanel
        component: Panel { property int ancorSide: Panel.PanelSide.Left }
    }
    LazyLoader {
        active: Sett.enableRightPanel
        component: Panel { property int ancorSide: Panel.PanelSide.Right }
    }
}

// PanelWindow {
//     id: toplevel

//     property var animationS: 0.1

//     anchors {
//         left: true
//         bottom: true
//         right: true
//     }
//     implicitHeight: 20
//     color: Style.backGround

//     Item {
//         anchors.centerIn: parent
//         height: toplevel.height; width: perfomanceWid.width

//         Timer {
//             id: timeA
//             interval: 1000
//             onTriggered: {
//                 toplevel.animationS = 0
//                 timeB.running = true
//             }
//         }

//         Timer {
//             id: timeB
//             interval: 1000
//             onTriggered: perfomanceWid.visible = false
//         }

//         PopupWindow {
//             id: perfomanceWid
//             anchor.window: toplevel
//             anchor.rect.x: parentWindow.width / 2 - width / 2
//             anchor.rect.y: - parentWindow.height - height + toplevel.height
//             implicitHeight: perfomance.height * animationS; implicitWidth: perfomance.width
//             visible: false
//             color: "transparent"
            
//             Item {
//                 anchors {
//                     verticalCenter: parent.verticalCenter
//                     bottom: parent.bottom
//                 }
//                 height: perfomance.height * animationS; width: perfomance.width
//                 Perfomance {
//                     id: perfomance
//                 }
//             }
            

//             MouseArea1 {
//                 anchors.fill: parent
//                 hoverEnabled: true
//                 onEntered: {
//                     timeA.running = false
//                     perfomanceWid.visible = true
//                 }
//                 onExited: timeA.running = true
//             }
//         }

//         RectForeground {
//             anchors.centerIn: parent
//             height: parent.height / 2; width: parent.width - 20
//         }

//         MouseArea {
//             anchors.fill: parent
//             hoverEnabled: true
//             onEntered: {
//                 timeA.running = false
//                 perfomanceWid.visible = true
//                 toplevel.animationS = 1
//             }
//             onExited: timeA.running = true
//         }
//     }
// }