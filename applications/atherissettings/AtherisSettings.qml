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
            UIState.atherisSettings.isOpen = false
            mainLoader.active = false
        }
    }

    readonly property int unitSize: Theme.unitSize.normal
    readonly property int margine: Theme.margine.large

    RectForeground {
        id: settingsChoser
        anchors {
            left: parent.left
            leftMargin: margine
        }
        height: root.height - margine * 2; width: unitSize * 8

        Column {
            anchors.fill: parent
            spacing: Theme.spacing.large
            
            Repeater {
                model: UIState.atherisSettings.modules
                delegate: ButtonStyled {
                    height: unitSize; width: parent.width
                    text: modelData
                    onClicked: UIState.atherisSettings.modul = modelData
                    isActive: UIState.atherisSettings.modul === modelData
                }
            }
        }
    }

    ScrollStyled {
        anchors {
            right: parent.right
            rightMargin: margine
        }
        height: root.height - Theme.padding.large * 2
        width: root.width - settingsChoser.width - margine * 3

        Loader {
            id: mainLoader
            anchors.fill: parent

            active: UIState.atherisSettings.isOpen
            source: {
                switch(UIState.atherisSettings.modul) {
                    case "general": return "General.qml";
                    case "display": return "Display.qml";
                    case "theme": return "Theme.qml";
                    case "bluetooth": return "Bluetooth.qml";
                    case "network": return "Network.qml";
                    return "";
                }
            }
        }
    }

    Connections {
        target: UIState
        function onAtherisSettingsChanged() {
            if (UIState.atherisSettings.isOpen) mainLoader.active = true
        }
    }
}