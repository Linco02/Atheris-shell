import QtQuick
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.components.controls
import qs.config
import qs.services

RectForeground {
    id: root
    height: parent.height; width: statusContainer.width

    RowStyled {
        id: statusContainer
        height: parent.height
        leftPadding: Style.padding.normal; rightPadding: Style.padding.normal

        TextOwn {text: SPipewire.iconVolume}

        Loader {
            active: SUPower.displayDevice.isLaptopBattery
            sourceComponent: TextOwn {
                text: SUPower.batteryIcon
            }
        }

        TextOwn {text: SBluetooth?.isBluetoothOn ? "󰂯" : "󰂲"}
        
        // TextOwn {text: SNetwork.currentNetworkSimbol}

        Loader {
            active: SUPower?.power.hasPerformanceProfile
            sourceComponent: TextOwn {
                text: (Icon.powerProfilesIcon.find(p => p.label === SUPower?.powerProfile) ?? {icon: ""}).icon
            }
        }
        
        TextOwn {text: SLanguage.currentLayoutName}
    }

    component TextOwn: TextStyledH {
        height: root.height; width: height
    }

    TapHandler {onTapped: SWManager.controlCenter("main")}
}