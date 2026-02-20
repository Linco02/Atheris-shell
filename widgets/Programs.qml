import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.settings
import qs.components

RectForeground {
    id: programsWidget
    height: panelHeight - Style.padding2x; width: programsRow.width + Style.padding2x

    function setIcons(appId) {
        let name = appId.split('.').pop().toLowerCase()
        let path = Quickshell.iconPath(name, true)
        let sourceIcons = Quickshell.iconPath("image-missing")
        
        if (path.length > 0) {
            sourceIcons = path
        }

        return sourceIcons
    }

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
                    id: programIcons
                    anchors.centerIn: parent
                    implicitSize: 16
                    source: setIcons(modelData.appId)
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