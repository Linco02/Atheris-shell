import QtQuick
import qs.components.popups
import qs.config

PopJump {
    id: dashboard
    containerH: mainLoader.height
    containerW: mainLoader.width
    isOpen: Global.isDashboardOpen
    onClosedPop: {Global.isDashboardOpen = false}

    Loader {
        id: mainLoader
        active: Global.isDashboardOpen
        source: {
            switch(Global.isDashboardModule) {
                case "dashboard": return "DashBoard.qml";
                case "wallpaper": return "WallpaperSelector.qml";
                case "programs": return "ProgramsSelector.qml";
            }
        }
    }
}