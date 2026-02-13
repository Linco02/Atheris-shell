import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.settings
import qs.components

RectForeground {
    id: root
    height: panelHeight - Style.padding2x; width: programsRow.width + Style.padding2x

    RowStyle1 {
        id: programsRow
        anchors.centerIn: parent
        
        Repeater {
            model: ToplevelManager.toplevels

            Rectangle {
                height: root.height; width: modelData.activated ? root.height + Style.padding2x : root.height
                color: modelData.activated ? Style.activeColor : "transparent"
                radius: Style.radius

                IconImage {
                    anchors.centerIn: parent
                    implicitSize: 16
                    source: Quickshell.iconPath(modelData.appId.split('.').pop().toLowerCase())

                }
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        modelData.activate()
                    }
                }
            }
        }
    }
}