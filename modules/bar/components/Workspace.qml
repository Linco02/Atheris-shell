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

        model: SWorkspace.eworkspaces

        delegate: Rect {
            height: isHorizontal ? barWidth - Theme.stock.small : barWidth * 1.5
            width: isHorizontal ? barWidth * 1.5 : barWidth - Theme.stock.small

            radius: 0
            color: modelData.focused
                ? Theme.colors.active : modelData.occupied
                ? Theme.colors.inactive : "transparent"
            topLeftRadius: modelData.neighbor.previous ? 0 : cornerRadius
            bottomRightRadius: modelData.neighbor.following ? 0 : cornerRadius
            topRightRadius: isHorizontal
                ? (modelData.neighbor.following ? 0 : cornerRadius)
                : (modelData.neighbor.previous ? 0 : cornerRadius)
            bottomLeftRadius: isHorizontal
                ? (modelData.neighbor.previous ? 0 : cornerRadius)
                : (modelData.neighbor.following ? 0 : cornerRadius)


            TextStyledH {
                anchors.centerIn: parent
                text: modelData.focused ? "●" 
                    : modelData.occupied ? "◉"
                    : "○"
            }

            TapHandler {onTapped: SWorkspace.moveToWorkspace(modelData)}
        }
    }


}