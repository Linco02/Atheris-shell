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
    property bool isHorizontal: true
    property int barWidth: Theme.barWidth
    property int count: SWorkspace.existingQuantityWorkspaces

    ListView {
        id: workspaceContainer
        anchors.centerIn: parent
        width: isHorizontal ? count * (barWidth * 1.5) : (root.width)
        height: isHorizontal ? (root.height) : count * (barWidth * 1.5)
        orientation: isHorizontal ? ListView.Horizontal : ListView.Vertical
        interactive: false

        model: SWorkspace.existingQuantityWorkspaces

        delegate: Rect {
            height: isHorizontal ? barWidth - Theme.stock.small : barWidth * 1.5
            width: isHorizontal ? barWidth * 1.5 : barWidth - Theme.stock.small
            radius: 0

            color: isFocused
                ? Theme.colors.active : isOccupied
                ? Theme.colors.inactive : "transparent"

            topLeftRadius: neighbor.previous ? 0 : cornerRadius
            bottomRightRadius: neighbor.following ? 0 : cornerRadius
            topRightRadius: isHorizontal
                ? (neighbor.following ? 0 : cornerRadius)
                : (neighbor.previous ? 0 : cornerRadius)
            bottomLeftRadius: isHorizontal
                ? (neighbor.previous ? 0 : cornerRadius)
                : (neighbor.following ? 0 : cornerRadius)

            property int idWorkspace: modelData + 1
            property var workspace: SWorkspace.getWorkspace(idWorkspace)
            property var neighbor: SWorkspace.hasNeighbor(idWorkspace)
            property bool isOccupied: SWorkspace.getOccupied(workspace)
            property bool isFocused: workspace?.focused ?? false

            TextStyledH {
                anchors.centerIn: parent
                isHorizontal: root.isHorizontal
                text: isFocused ? "●" 
                    : isOccupied ? "◉"
                    : "○"
            }

            TapHandler {onTapped: SWorkspace.moveToWorkspace(idWorkspace, isFocused)}

            Behavior on topLeftRadius{NumberAnim{}}
            Behavior on bottomRightRadius{NumberAnim{}}
            Behavior on topRightRadius{NumberAnim{}}
            Behavior on bottomLeftRadius{NumberAnim{}}
        }

        Behavior on width{NumberAnim{}}
    }
}