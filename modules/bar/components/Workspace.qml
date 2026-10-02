import QtQuick
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.components.animations
import qs.config
import qs.services

RectForeground {
    id: root
    height: isHorizontal ? barWidth - Theme.stock.small: workspaceContainer.height
    width: isHorizontal ? workspaceContainer.width : barWidth - Theme.stock.small

    readonly property int cornerRadius: Theme.radius.normal
    readonly property int barWidth: Theme.barWidth
    readonly property int wsCount: SWorkspace.maxExistId
    property bool isHorizontal: true

    ListViewMutable {
        id: workspaceContainer
        anchors.centerIn: parent
        isHorizontal: root.isHorizontal
        width: isHorizontal ? wsCount * (barWidth * 1.5) : root.width
        height: isHorizontal ? root.height : wsCount * (barWidth * 1.5)

        model: SWorkspace.workspacesList

        delegate: Rect {
            visible: wsId <= wsCount
            height: isHorizontal ? barWidth - Theme.stock.small : barWidth * 1.5
            width: isHorizontal ? barWidth * 1.5 : barWidth - Theme.stock.small
            radius: 0
            color: isFocused
                ? Theme.colors.active : isOccupied
                ? Theme.colors.inactive : "transparent"
            topLeftRadius: previousNeighbor ? 0 : cornerRadius
            bottomRightRadius: followingNeighbor ? 0 : cornerRadius
            topRightRadius: isHorizontal
                ? (followingNeighbor ? 0 : cornerRadius)
                : (previousNeighbor ? 0 : cornerRadius)
            bottomLeftRadius: isHorizontal
                ? (previousNeighbor ? 0 : cornerRadius)
                : (followingNeighbor ? 0 : cornerRadius)

            required property int wsId
            required property bool isOccupied
            required property bool isFocused
            required property bool previousNeighbor
            required property bool followingNeighbor

            TextStyledH {
                anchors.centerIn: parent
                isHorizontal: root.isHorizontal
                text: isFocused ? "●" 
                    : isOccupied ? "◉"
                    : "○"
            }

            TapHandler {onTapped: SWorkspace.moveToWorkspace(wsId, isFocused)}

            Behavior on topLeftRadius{NumberAnim{}}
            Behavior on bottomRightRadius{NumberAnim{}}
            Behavior on topRightRadius{NumberAnim{}}
            Behavior on bottomLeftRadius{NumberAnim{}}
        }

        Behavior on width{NumberAnim{}}
    }
}