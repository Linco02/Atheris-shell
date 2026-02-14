import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.settings
import qs.components

RectForeground {
    id: programsWidget
    height: panelHeight - Style.padding2x; width: programsRow.width + Style.padding2x

    RowStyle1 {
        id: programsRow
        anchors.centerIn: parent
        
        Repeater {
            model: ToplevelManager.toplevels

            Rectangle {
                height: programsWidget.height; width: modelData.activated ? programsWidget.height + Style.padding2x : programsWidget.height
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