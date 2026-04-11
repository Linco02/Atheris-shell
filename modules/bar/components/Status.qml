import QtQuick
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.components.controls
import qs.config
import qs.services
import "./status"

RectForeground {
    id: root
    height: parent.height; width: statusContainer.width

    RowSpaced {
        id: statusContainer
        height: parent.height
        leftPadding: Global.padding.normal; rightPadding: Global.padding.normal

        TextOwn { text: PipewireServices.iconVolume }
        TextOwn { text: UPowerServices.batteryIcon }
        TextOwn { text: "󰂯" }
         // 󰂰 󰂲 }
        TextOwn { text: NetworkServices.currentNetworkSimbol }
        TextOwn { text: LanguageServices.currentLayoutName }
    }

    component TextOwn: TextStyledH {
        height: root.height; width: height
    }

    TapHandler { onTapped: Global.isControlCenterOpen = !Global.isControlCenterOpen }
}