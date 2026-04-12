import QtQuick
import qs.components
import qs.components.shapes
import qs.components.windows
import qs.components.controls
import qs.config

Floating {
    id: root
    onVisibleChanged: if (!visible) Global.isAtherisSettingsOpen = false

    property var settingsList: ["Bar", "Background", "Theme", "General"]

    Row {
        height: root.height

        Column {
            id: settingsChoser
            width: 200
            
            Repeater {
                model: settingsList
                delegate: ButtonStyled {
                    height: 20; width: parent.width
                    text: modelData
                }
            }
        }

        RectForeground {
            height: root.height; width: root.width - settingsChoser.width
            
            Column {
                id: settingsContainer
            }
        }
    }
}