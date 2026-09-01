import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.config
import qs.services

ButtonTripled {
    width: parent.width
    icon: SNetwork.getNerdIcon(SNetwork.currentNetwork)
    textTop: "Wifi"
    textBottom: SNetwork.currentNetwork?.name || ""
    isActive: SNetwork.isWifiOn
    onClicked: UIState.controlCenterModul = "wifi"
}