import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.config
import qs.services

ButtonTripled {
    width: parent.width
    icon: network.icon
    textTop: "Wifi"
    textBottom: network.ssid
    onClicked: Global.controlCenterModul = "wifi"

    readonly property var network: NetworkServices.currentWifi
}