import QtQuick
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.config
import qs.services

RectForeground {
    id: root
    height: isHorizontal ? barWidth - Theme.stock.small : clockContainer.height + Theme.stock.small
    width: isHorizontal ? clockContainer.width + Theme.stock.small : barWidth - Theme.stock.small

    property int barWidth: Theme.barWidth
    property bool isHorizontal: true
    property var cloclList: isHorizontal
        ? [STime.hour, ":", STime.minute]
        : [STime.hour, STime.minute]

    ListViewMutable {
        id: clockContainer
        anchors.centerIn: parent
        height: isHorizontal ? parent.height : contentHeight
        width: isHorizontal ? contentWidth : parent.width
        isHorizontal: root.isHorizontal

        model: cloclList
        delegate: TextStyledH {
            text: modelData
            isHorizontal: root.isHorizontal
            width: root.isHorizontal ? implicitWidth : clockContainer.width
            height: root.isHorizontal ? clockContainer.height : implicitHeight
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    TapHandler {onTapped: {SWManager.controlAtherisCenter("dashboard", "dash")}}
}