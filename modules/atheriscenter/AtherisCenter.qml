import QtQuick
import qs.components.windows
import qs.config

PopJump {
    id: dashboard
    containerH: mainLoader.height
    containerW: mainLoader.width
    isOpen: UIState.isCommandCenterOpen
    onClosedPop: {
        UIState.isCommandCenterOpen = false
        mainLoader.active = false
    }

    Loader {
        id: mainLoader
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        active: UIState.isCommandCenterOpen
        source: {
            switch(UIState.commandCenterModule) {
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
        function onIsCommandCenterOpenChanged() {
            if (UIState.isCommandCenterOpen) mainLoader.active = true
        }
    }
}