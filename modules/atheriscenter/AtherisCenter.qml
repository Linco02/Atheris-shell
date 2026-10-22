import QtQuick
import qs.components.windows
import qs.config

PopJump {
    id: dashboard
    containerH: mainLoader.height
    containerW: mainLoader.width
    isOpen: UIState.atherisCenter.isOpen
    onClosedPop: {
        UIState.atherisCenter.isOpen = false
        mainLoader.active = false
    }

    Loader {
        id: mainLoader
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        active: UIState.atherisCenter.isOpen
        source: {
            switch(UIState.atherisCenter.modul) {
                case "dashboard": return "DashBoard.qml";
                case "wallpaper": return "WallpaperSelector.qml";
                case "programs": return "ProgramsSelector.qml";
                case "command" : return "Command.qml";
                return "";
            }
        }
    }

    Connections {
        target: UIState
        function onAtherisCenterChanged() {
            if (UIState.atherisCenter.isOpen) mainLoader.active = true
        }
    }
}