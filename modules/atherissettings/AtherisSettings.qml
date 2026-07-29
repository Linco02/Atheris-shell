import QtQuick
import qs.components
import qs.components.shapes
import qs.components.windows
import qs.components.controls
import qs.components.containers
import qs.config

Floating {
    id: root
    onVisibleChanged: if (!visible) Global.isAtherisSettingsOpen = false

    SpacedRow {
        height: root.height

        SpacedColumn {
            id: settingsChoser
            width: 200
            
            Repeater {
                model: Global.atherisSettingsModules
                delegate: ButtonStyled {
                    height: 20; width: parent.width
                    text: modelData
                }
            }
        }

        RectForeground {
            height: root.height; width: 10
        }

        Item {
            height: root.height; width: root.width - settingsChoser.width
            
            Display { }
            
            // Column {
            //     id: settingsContainer

            //     Display { }
            // }
        }
    }
}