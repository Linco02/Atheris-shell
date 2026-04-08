import QtQuick
import qs.components.popups
import qs.config

PopJump {
    id: dashboard
    containerH: mainLoader.height
    containerW: mainLoader.width
    isOpen: Global.isControlCenterOpen
    onClosedPop: {
        Global.isControlCenterOpen = false
        mainLoader.active = false
    }

    Loader {
        id: mainLoader
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        active: Global.isControlCenterOpen
        source: {
            switch(Global.controlCenterModul) {
                case "dashboard": return "DashBoard.qml";
                case "wallpaper": return "WallpaperSelector.qml";
                case "programs": return "ProgramsSelector.qml";
                case "command" : return "Command.qml";
                return "";
            }
        }
    }

    Connections {
        target: Global
        function onIsControlCenterOpenChanged() {
            if (Global.isControlCenterOpen) mainLoader.active = true
        }
    }
}