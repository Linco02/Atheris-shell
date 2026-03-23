import QtQuick
import QtQuick.Controls
import qs.config
import qs.components.animations
import qs.components.containers
import qs.components.shapes
import qs.components

PopJump {
    id: dashboard
    anchor {
        window: root
        rect.x: root.width / 2 - width / 2
        rect.y: root.height
    }
    implicitHeight: 600; implicitWidth: 1200

    property int space: Appearance.spacing.normal
    property int gap: 60
    property int rotate: 180

    Connections {
        target: GlobalStates
        function onIsDashboardOpenChanged() {
            if (!GlobalStates.isDashboardOpen) {
                closeMenu()
            } else
                openMenu()
        }
    }

    Connections {
        target: dashboard

        function onPopClosed() {
            GlobalStates.isDashboardOpen = false
        }
    }

    Loader {
        id: mainLoader
        active: GlobalStates.isDashboardModule !== ""
        source: {
            switch(GlobalStates.isDashboardModule) {
                case "dashboard": return "DashWraper.qml";
                case "wallpaper": return "WallpaperSelector.qml";
                case "programs": return "ProgramsSelector.qml";
            }
        }
    }
}