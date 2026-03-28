import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.config
import qs.services
import qs.components.animations
import qs.components.containers
import qs.components.shapes

RectForeground {
    id: programsWidget
    height: root.height - Appearance.padding.normal; width: programsRow.width

    RowNormal {
        id: programsRow
        anchors.centerIn: parent
        spacing: 0
        
        Repeater {
            model: ToplevelManager.toplevels

            Rectangle {
                id: programBox
                height: programsWidget.height
                width: programsWidget.height + Appearance.padding.normal
                color: modelData.activated ? Colors.active : "transparent"
                radius: Appearance.radius.normal

                IconImage {
                    id: programIcons
                    anchors.centerIn: parent
                    implicitSize: 16
                    source: AppIcons.getIcon(modelData.appId)
                }
                
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        if (!modelData.activated)
                            programBox.color = Colors.active
                    }
                    onExited: {
                        if (!modelData.activated)
                            programBox.color = Colors.surfaceRaised
                    }
                    onClicked: {
                        modelData.activate()
                    }
                }

                Behavior on color { ColorAnim{ } }
            }
        }
    }
}