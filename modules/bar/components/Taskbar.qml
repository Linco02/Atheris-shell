import QtQuick
import Quickshell.Wayland
import qs.components.shapes
import qs.components.controls
import qs.config
import qs.services

import Quickshell.Hyprland

RectForeground {
    id: root
    height: parent.height; width: programsRow.width

    Row {
        id: programsRow
        anchors.centerIn: parent

        Repeater {
            model: ToplevelManager.toplevels
            delegate: ButtonIcon {
                height: root.height
                source: AppIcons.getIcon(modelData.appId)
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton
                onLeftClicked: modelData.activate()
                onMidleClicked: modelData.close()
            }
        }
    }

    // Repeater {
    //     model: HyprlandWorkspace.toplevels
    //     Item {
    //         Component.onCompleted: {console.log(modelData)}
    //     }
    // }
    Component.onCompleted: {console.log(HyprlandWorkspace.toplevels)}

    // Repeater {
    //     model: Hyprland.activeToplevel
    //     Item {
    //         Repeater {
    //             model: modelData.workspace.toplevels
    //             Component.onCompleted: {console.log(modelData.values)}
    //         }
    //         Component.onCompleted: {console.log(modelData.workspace.toplevels.values)}
    //     }
    // }

    
}

    // Component.onCompleted: {console.log(ToplevelManager.toplevels.workspace)}
    
    // SpacedRow {
    //     id: programsRow
    //     anchors.centerIn: parent
    //     spacing: 0
        
    //     Repeater {
    //         model: ToplevelManager.toplevels

    //         Rectangle {
    //             id: programBox
    //             height: programsWidget.height
    //             width: programsWidget.height + Global.padding.normal
    //             color: modelData.activated ? Colors.active : "transparent"
    //             radius: Global.radius.normal

    //             IconImage {
    //                 id: programIcons
    //                 anchors.centerIn: parent
    //                 implicitSize: 16
    //                 source: AppIcons.getIcon(modelData.appId)
    //             }
                
    //             MouseArea {
    //                 anchors.fill: parent
    //                 hoverEnabled: true
    //                 onEntered: {
    //                     if (!modelData.activated)
    //                         programBox.color = Colors.active
    //                 }
    //                 onExited: {
    //                     if (!modelData.activated)
    //                         programBox.color = Colors.surfaceRaised
    //                 }
    //                 onClicked: {
    //                     modelData.activate()
    //                 }
    //             }

    //             Behavior on color { ColorAnim{ } }
    //         }
    //     }
    // }