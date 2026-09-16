import QtQuick
import Quickshell.Widgets
import qs.config
import qs.services
import qs.components
import qs.components.shapes
import qs.components.containers

Item {
    id: root
    height: Theme.barWidth - Theme.padding.small * 2; width: deviceContainer.width

    RowStyled {
        id: deviceContainer

        Repeater {
            model: SBluetooth.connectedDevices

            delegate: RectForeground {
                height: root.height; width: deviceContainer.width
                visible: true

                RowStyled {
                    id: deviceContainer
                    anchors.centerIn: parent
                    leftPadding: Theme.padding.small; rightPadding: Theme.padding.normal

                    IconImage {
                        source: SIcon.getIcon(modelData.icon)
                        implicitSize: root.height - Theme.padding.small
                    }

                    TextStyled {
                        anchors.verticalCenter: parent.verticalCenter
                        text: Math.floor(modelData.battery * 100).toString() + "%"
                    }
                }
            }
        }
    }
}