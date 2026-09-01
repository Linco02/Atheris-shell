import QtQuick
import Quickshell.Widgets
import qs.config
import qs.services
import qs.components
import qs.components.shapes
import qs.components.containers

Item {
    id: root
    height: parent.height; width: deviceContainer.width

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
                    leftPadding: Style.padding.small; rightPadding: Style.padding.normal

                    IconImage {
                        source: SIcon.getIcon(modelData.icon)
                        implicitSize: root.height - Style.padding.small
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