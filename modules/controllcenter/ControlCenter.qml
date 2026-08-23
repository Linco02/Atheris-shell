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
    positionX: panel.width - root.width - Style.padding.normal
    isOpen: UIState.isControlCenterOpen
    onClosedPop: UIState.isControlCenterOpen = false
    position: "right"


    ColumnStyled {
        id: controlCenterContainer

        Loader {
            id: controlCenterModules
            height: 900; width: 400
            active: true
            source: {
                switch(UIState.controlCenterModul) {
                    case "sound": return "./controls/SoundControl.qml";
                    case "wifi": return "./controls/WifiControl.qml";
                    case "main": return "MainCenter.qml";
                    case "bluetooth": return "./controls/BluetoothControl.qml"
                    return "";
                }
            }

            onLoaded: flash.start()
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