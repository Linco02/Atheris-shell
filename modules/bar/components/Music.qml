import QtQuick
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.animations
import qs.components.containers
import qs.config
import qs.services

RectForeground {
    id: root
    visible: playerExist
    height: isHorizontal ? barWidth - Theme.stock.small: musicContainer.height + Theme.stock.small
    width: isHorizontal ? musicContainer.width + Theme.stock.small : barWidth - Theme.stock.small

    property bool isHorizontal: true
    property int barWidth: Theme.barWidth

    property bool playerExist: SMris.playerExist
    property bool isPlayerPlay: SMris.isplayerActivePlay
    property var playerActive: SMris.playerActive

    GridRotable {
        id: musicContainer
        anchors.centerIn: parent
        isHorizontal: root.isHorizontal
        count: 3

        IconImage {
            implicitSize: (isHorizontal ? root.height : root.width) - Theme.padding.small
            source: playerExist ? SIcon.getIcon(playerActive.identity) : ""
        }

        RunningText {
            height: isHorizontal ? root.height - Theme.padding.small : (textLength > 200 ? 200 : textLength)
            width: isHorizontal ? (textLength > 200 ? 200 : textLength) : root.width - Theme.padding.small
            isHorizontal: root.isHorizontal
            text: playerActive?.trackTitle ?? "..."
            runText: textLength > 200
            clip: true

            TapHandler {onTapped: {SWManager.controlAtherisCenter("dashboard", "music")}}
            Behavior on width {NumberAnim {}}
            Behavior on height {NumberAnim {}}
        }

        ButtonTransparent {
            height: (isHorizontal ? root.height : root.width) - Theme.padding.small
            width: height
            text: isPlayerPlay ? "" : ""
            onClicked: isPlayerPlay ? SMris.pauseMris(playerActive)
                : SMris.playMris(playerActive)
        }
    }
}