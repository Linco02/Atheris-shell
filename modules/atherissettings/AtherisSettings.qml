import QtQuick
import qs.components
import qs.components.shapes
import qs.components.windows
import qs.components.controls
import qs.components.containers
import qs.config

Floating {
    id: root
    title: "Atheris-Settings"
    minimumSize: "1000x700"
    implicitHeight: 800; implicitWidth: 1400
    onVisibleChanged: {
        if (!visible) {
            UIState.isAtherisSettingsOpen = false
            mainLoader.active = false
        }
    }

    Row {
        RectForeground {
            id: settingsChoser
            height: root.height; width: 200

            ColumnStyled {
                anchors.fill: parent
                
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
        }

        Loader {
            id: mainLoader
            height: root.height; width: root.width - settingsChoser.width
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

    Connections {
        target: UIState
        function onIsAtherisSettingsOpenChanged() {
            if (UIState.isAtherisSettingsOpen) mainLoader.active = true
        }
    }
}