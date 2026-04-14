import QtQuick
import QtQuick.Layouts
import qs.components.shapes
import qs.components.windows
import qs.components.controls
import qs.components.containers
import qs.components.animations
import qs.config
import "./controls"

PopFade {
    id: root
    containerH: controlCenterContainer.height
    containerW: controlCenterContainer.width
    positionX: panel.width - root.width - Global.padding.normal
    isOpen: Global.isControlCenterOpen
    onClosedPop: Global.isControlCenterOpen = false
    isLeft: false


    ColumnSpaced {
        id: controlCenterContainer

        Loader {
            id: controlCenterModules
            height: 600; width: 400
            active: true
            source: {
                switch(Global.controlCenterModul) {
                    case "sound": return "./controls/SoundControl.qml";
                    case "wifi": return "./controls/WifiControl.qml";
                    case "": return "MainCenter.qml";
                    return "";
                }
            }

            onLoaded: flash.start()
        }

        Loader {
            id: controlCenterButton
            height: 40; width: parent.width
            active: Global.controlCenterModul !== ""
            sourceComponent: ButtonStyled {
                anchors.fill: parent
                text: "󰁠 Назад 󰁠"
                onClicked: Global.controlCenterModul = ""
            }
        }
    }

    NumberAnim {
        id: flash
        target: controlCenterContainer
        property: "opacity"
        from: 0
        to: 1
    }
}