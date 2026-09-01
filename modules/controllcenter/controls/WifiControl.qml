import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

ScrollStyled {
    anchors.fill: parent
    padding: Style.padding.normal

    ColumnStyled {
        width: parent.width

        Item {
            height: 30; width: parent.width

            ButtonStyled {
                anchors {
                    left: parent.left
                }
                height: parent.height; width: height
                text: ""
                onClicked: SWManager.controlCenter("main")
            }

            ButtonToggle {
                id: toggleBluetooth
                anchors.right: parent.right
                height: parent.height
                onClicked: SNetwork.toggleWifi()
                isActive: SNetwork.isWifiOn
            }
        }

        TextStyled {
            leftPadding: Style.padding.large
            text: "Активна мережа"
        }

        Loader {
            active: SNetwork?.currentNetwork?.connected || false
            width: active ? parent.width : 0
            sourceComponent: ButtonTripled {
                height: 40; width: parent.width
                icon: SNetwork.getNerdIcon(SNetwork?.currentNetwork)
                textTop: SNetwork?.currentNetwork?.name || ""
                textBottom: SNetwork.getDeviceStatus(SNetwork?.currentNetwork)
                isActive: true
                onClicked: SNetwork.disconnectNetwork(SNetwork?.currentNetwork)
            }
        }

        TextStyled {
            leftPadding: Style.padding.large
            text: "Доступні мережі"
        }

        Repeater {
            model: SNetwork.anotherNetworks
            delegate: DeviceButton {}
        }
    }

    component DeviceButton: ButtonTripled {
        height: 40; width: parent.width
        icon: SNetwork.getNerdIcon(modelData)
        textTop: modelData?.name
        textBottom: SNetwork?.getDeviceStatus(modelData)
        isActive: false
        onClicked: SNetwork.connectNetwork(modelData)
    }

    Component.onCompleted: SNetwork.checkConnectivity()
}