import QtQuick
import qs.components.windows
import qs.config

PopJump {
    id: dashboard
    containerH: mainLoader.height
    containerW: mainLoader.width
    isOpen: UIState.isAtherisCenterOpen
    onClosedPop: {
        UIState.isAtherisCenterOpen = false
        mainLoader.active = false
    }

    Loader {
        id: mainLoader
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        active: UIState.isAtherisCenterOpen
        source: {
            switch(UIState.atherisCenterModule) {
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
        function onIsAtherisCenterOpenChanged() {
            if (UIState.isAtherisCenterOpen) mainLoader.active = true
        }
    }
}