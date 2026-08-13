import QtQuick
import Quickshell.Widgets
import qs.config
import qs.services
import qs.components
import qs.components.shapes
import qs.components.containers

Item {
    id: root
    height: parent.height; width: bluetoothContainer.width

    RowStyled {
        id: bluetoothContainer

        Repeater {
            model: SBluetooth.connectedDevices

            delegate: RectForeground {
                height: root.height; width: deviceContainer.width + Style.padding.normal
                visible: true

                RowStyled {
                    id: deviceContainer
                    anchors.centerIn: parent

                    IconImage {
                        source: SAppIcons.getIcon(modelData.icon)
                        implicitSize: root.height - Style.padding.small
                    }

                    TextStyled {
                        text: (modelData.battery * 100).toString() + "%"
                    }
                }
            }
        }
    }
}