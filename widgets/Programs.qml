//@ pragma IconTheme Papirus
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.settings
import qs.components

RectForeground {
    id: root
    height: 20; width: 120
    Row {
        Repeater {
            model: ToplevelManager.toplevels

            Item {
                // visible: modelData.id > 0
                height: root.height; width: root.height
                // color: modelData.focused ? "red" : "blue"

                IconImage {
                    height: parent.height; width: parent.height
                    // Передаємо appId вікна як назву іконки
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