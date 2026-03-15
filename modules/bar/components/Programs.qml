import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.config
import qs.components.animations
import qs.components.containers
import qs.components.shapes

RectForeground {
    id: programsWidget
    height: root.height - Appearance.padding.normal; width: programsRow.width

    function setIcons(appId) {
        let name = appId.split('.').pop().toLowerCase()
        let path = Quickshell.iconPath(name, true)
        let sourceIcons = Quickshell.iconPath("image-missing")
        const iconMap = {
            "codium": "vscodium",
            "org.kde.dolphin": "dolphin",
            "org.telegram.desktop": "telegram"
        }   
        
        if (path.length > 0) {
            sourceIcons = path
        } else if (iconMap[appId]) {
            sourceIcons = Quickshell.iconPath(iconMap[appId], true)
        } else {
            console.log(appId)
        }

        return sourceIcons
    }

    // function setIcons(appId) {
    //     const fallback = Quickshell.iconPath("image-missing", true)

    //     const entry = DesktopEntries.heuristicLookup(appId)
    //     if (entry && entry.icon)
    //         return Quickshell.iconPath(entry.icon, true)

    //     return fallback
    // }

    RowNormal {
        id: programsRow
        anchors.centerIn: parent
        spacing: 0
        
        Repeater {
            model: ToplevelManager.toplevels

            Rectangle {
                id: programBox
                height: programsWidget.height
                width: programsWidget.height + Appearance.padding.normal
                color: modelData.activated ? Colors.active : "transparent"
                radius: Appearance.radius.normal

                IconImage {
                    id: programIcons
                    anchors.centerIn: parent
                    implicitSize: 16
                    source: setIcons(modelData.appId)
                }
                
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        if (!modelData.activated)
                            programBox.color = Colors.active
                    }
                    onExited: {
                        if (!modelData.activated)
                            programBox.color = Colors.surfaceRaised
                    }
                    onClicked: {
                        modelData.activate()
                    }
                }

                Behavior on color { ColorAnim{ } }
            }
        }
    }
}