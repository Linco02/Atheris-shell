import QtQuick
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

RectForeground {
    id: root
    visible: count > 0
    height: isHorizontal ? barWidth - Theme.stock.small : (barWidth - Theme.stock.small) * count
    width: isHorizontal ? (barWidth - Theme.stock.small) * count : barWidth - Theme.stock.small

    property bool isHorizontal: true
    property int barWidth: Theme.barWidth
    property int count: SWayland.amountTopLevels

    ListViewMutable {
        id: taskbarContainer
        anchors.fill: parent
        isHorizontal: root.isHorizontal

        model: SWayland.topLevels
        delegate: ButtonIcon {
            source: modelData.appId
            height: isHorizontal ? root.height : root.width
            iconSize: height - Theme.padding.small
            onClicked: modelData.activate()
            active: modelData.activated
        }
    }
}