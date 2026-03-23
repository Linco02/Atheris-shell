import QtQuick
import QtQuick.Controls
import qs.config
import qs.components.animations
import qs.components.containers
import qs.components.shapes
import qs.components

PopJump {
    anchor {
        window: root
        rect.x: root.width / 2 - width / 2
        rect.y: root.height
    }
    implicitHeight: 600; implicitWidth: 1000

    property int space: Appearance.spacing.normal
    property int gap: 60

    property int rotate: 180


    Loader {
        id: mainLoader
        // anchors {
        //     top: parent.top
        //     horizontalCenter: parent.horizontalCenter
        // }
        // width: childrenRect.width
        // height: childrenRect.height
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