import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.components.controls
import qs.services
import qs.config

ScrollStyled {
    id: root
    anchors.fill: parent

    property var adapter: SBluetooth?.adapter

    ColumnStyled {
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height
        width: root.width * 0.9

        RectForeground {
            id: settingsContainer
            height: settingsGrid.height; width: parent.width
            clip: true

            Grid {
                id: settingsGrid
                width: parent.width
                columns: 2
                padding: Style.padding.large
                spacing: Style.padding.large

                TextStyledB {
                    id: name
                    width: parent.width - toggle.width - Style.padding.large * 3
                    text: "Wifi"
                }
                ButtonToggle {
                    id: toggle
                    height: name.height
                    isActive: SNetwork?.isWifiOn
                    onClicked: SNetwork.toggleWifi()
                }

                // TextStyledB {
                //     width: name.width
                //     text: "Scan"
                // }
                // ButtonToggle {
                //     height: name.height
                //     isActive: SNetwork?.scannerState
                //     onClicked: SNetwork.toggleScan()
                // }
            }
        }

        TextStyled {leftPadding: Style.padding.large; text: "Активна мережа"}

        RectActive {
            id: currentNetwork
            visible: SNetwork?.currentNetwork.connected
            height: 100
            width: parent.width
            clip: true

            RowStyled {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: Style.padding.large
                }

                TextStyled {
                    id: buttonIcon
                    fontSize: currentNetwork.height - Style.padding.large * 2
                    text: SNetwork.getNerdIcon(SNetwork.currentNetwork)
                    color: Theme.textAccent
                }

                TextStyledB {
                    anchors.verticalCenter: parent.verticalCenter
                    text: SNetwork.currentNetwork?.name || ""
                    color: Theme.textAccent
                }
            }

            ButtonStyled {
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: Style.padding.large
                }
                height: currentNetwork.height - Style.padding.large * 2
                text: "Від'єднатися"
                fontSize: Theme.fontSize * 1.6
                onClicked: SNetwork.disconnectNetwork(SNetwork.currentNetwork)
            }
        }

        TextStyled {leftPadding: Style.padding.large; text: "Доступні мережі"}

        Repeater {
            model: SNetwork?.anotherNetworks
            delegate: RectForeground {
                id: currentNetwork
                height: 100; width: parent.width
                clip: true

                RowStyled {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: Style.padding.large
                    }

                    TextStyled {
                        id: buttonIcon
                        fontSize: currentNetwork.height - Style.padding.large * 2
                        text: SNetwork.getNerdIcon(modelData)
                    }

                    TextStyledB {
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData.name || ""
                    }
                }

                ButtonStyled {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: Style.padding.large
                    }
                    height: currentNetwork.height - Style.padding.large * 2
                    text: "Під'єднатися"
                    fontSize: Theme.fontSize * 1.6
                    onClicked: SNetwork.connectNetwork(modelData)
                }
            }
        }
    }
}