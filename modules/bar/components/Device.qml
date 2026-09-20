import QtQuick
import Quickshell.Widgets
import qs.config
import qs.services
import qs.components
import qs.components.shapes
import qs.components.containers

RectForeground {
    id: root
    visible: SBluetooth.connectedDevices.length > 0
    height: isHorizontal ? barWidth - Theme.stock.small: deviceContainer.height + Theme.stock.small
    width: isHorizontal ? deviceContainer.width + Theme.stock.small : barWidth - Theme.stock.small

    property bool isHorizontal: true
    property int barWidth: Theme.barWidth

    ListViewMutable {
        id: deviceContainer
        anchors.centerIn: parent
        isHorizontal: root.isHorizontal
        height: isHorizontal ? root.height : contentHeight
        width: isHorizontal ? contentWidth : root.width
        spacing: Theme.spacing.normal

        model: SBluetooth.connectedDevices
        delegate: GridRotable {
            isHorizontal: root.isHorizontal
            spacing: 0
            count: 2

            Item {
                height: root.isHorizontal ? root.height : root.width
                width: height

                IconImage {
                    anchors.centerIn: parent
                    source: SIcon.getIcon(modelData.icon)
                    implicitSize: parent.height - Theme.padding.small
                }
            }

            TextStyledH {
                text: Math.floor(modelData.battery * 100) + (isHorizontal ? "%" : "")
                isHorizontal: root.isHorizontal
                height: root.isHorizontal ? deviceContainer.height : implicitHeight
                width: root.isHorizontal ? implicitWidth : deviceContainer.width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}