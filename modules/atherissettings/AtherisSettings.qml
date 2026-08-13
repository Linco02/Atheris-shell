import QtQuick
import qs.components
import qs.components.shapes
import qs.components.windows
import qs.components.controls
import qs.components.containers
import qs.config

Floating {
    id: root
    onVisibleChanged: {
        if (!visible) {
            UIState.isAtherisSettingsOpen = false
            mainLoader.active = false
        }
    }

    RowStyled {
        height: root.height

        ColumnStyled {
            id: settingsChoser
            width: 200
            
            Repeater {
                model: UIState.atherisSettingsModules
                delegate: ButtonStyled {
                    height: 20; width: parent.width
                    text: modelData
                    onClicked: UIState.atherisSettingsModule = modelData
                    isActive: UIState.atherisSettingsModule === modelData
                }
            }
        }

        RectForeground {
            height: root.height; width: 10
        }

        Item {
            height: root.height; width: root.width - settingsChoser.width

            Loader {
                id: mainLoader
                active: UIState.isAtherisSettingsOpen
                source: {
                    switch(UIState.atherisSettingsModule) {
                        case "general": return "General.qml";
                        case "display": return "Display.qml";
                        case "theme": return "Theme.qml";
                        case "bluetooth": return "Bluetooth.qml";
                        return "";
                    }
                }
            }
        }
    }

    Connections {
        target: UIState
        function onIsAtherisSettingsOpenChanged() {
            if (UIState.isAtherisSettingsOpen) mainLoader.active = true
        }
    }
}