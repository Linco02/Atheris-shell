import QtQuick
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.components.controls
import qs.config
import qs.services

RectForeground {
    id: root
    height: isHorizontal ? barWidth - Theme.stock.small : statusContainer.height + Theme.stock.small
    width: isHorizontal ?  statusContainer.width + Theme.stock.small : barWidth - Theme.stock.small

    property bool isHorizontal: true
    property int barWidth: Theme.barWidth

    ListViewMutable {
        id: statusContainer
        anchors.centerIn: parent
        isHorizontal: root.isHorizontal
        height: isHorizontal ? root.height : contentHeight
        width: isHorizontal ? contentWidth : root.width
        spacing: Theme.spacing.normal

        model: [
            SPipewire.iconVolume,

            SUPower?.displayDevice?.isLaptopBattery ? SUPower.batteryIcon : null,

            SBluetooth?.isBluetoothOn ? "󰂯" : "󰂲",

            SNetwork.getNerdIcon(SNetwork.currentNetwork),

            SUPower?.power?.hasPerformanceProfile
                ? (Icon.powerProfilesIcon.find(p => p.label === SUPower?.powerProfile) ?? {icon: ""}).icon
                : null,
            
            SLanguage.currentLayoutName
        ].filter(Boolean)

        delegate: TextStyledH {
            text: modelData
            isHorizontal: root.isHorizontal
            width: root.isHorizontal ? implicitWidth : statusContainer.width
            height: root.isHorizontal ? statusContainer.height : implicitHeight
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    TapHandler {onTapped: SWManager.controlCenter("main")}
}