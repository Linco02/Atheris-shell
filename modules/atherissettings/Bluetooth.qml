import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.components.controls
import qs.services
import qs.config

ScrollView {
    id: root
    anchors.fill: parent
    contentWidth: -1
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.vertical.policy: ScrollBar.AlwaysOff

    ColumnStyled {
        anchors.fill: parent

        RectForeground {
            id: bluetoothContainer
            anchors.horizontalCenter: parent.horizontalCenter
            height: 40 + Style.padding.large * 2; width: root.width * 0.9
        
            TextStyled {
                anchors.verticalCenter: parent.verticalCenter
                x: Style.padding.large
                text: "Bluetooth"
                font.pixelSize: bluetoothContainer.height - Style.padding.large * 2
            }

            ButtonToggle {
                anchors.verticalCenter: parent.verticalCenter
                x: bluetoothContainer.width - width - Style.padding.large
                height: bluetoothContainer.height - Style.padding.large * 2
                onClicked: SBluetooth.bluetoothToggle()
                isActive: SBluetooth.isBluetoothOn
            }
        }

        RectForeground {
            id: connectedDevicesContainer
            anchors.horizontalCenter: parent.horizontalCenter
            height: connectedDevicesColumn.height + Style.padding.large * 2; width: root.width * 0.9

            ColumnStyled {
                id: connectedDevicesColumn
                anchors.centerIn: parent
                TextStyled {text: "Підключені пристрої"}

                Repeater {
                    model: SBluetooth.connectedDevices
                    delegate: Rect {
                        id: connectedDevicesTemplate
                        height: 80
                        width: connectedDevicesContainer.width - Style.padding.large * 2
                        clip: true
                        color: Theme.surfaceTop

                        RowStyled {
                            anchors.verticalCenter: parent.verticalCenter
                            x: Style.padding.normal

                            IconImage {
                                id: buttonIcon
                                source: SAppIcons.getIcon(modelData.icon)
                                implicitSize: connectedDevicesTemplate.height - Style.padding.normal * 2
                            }

                            ColumnStyled {
                                anchors.verticalCenter: parent.verticalCenter

                                TextStyled {
                                    text: modelData.name || modelData.deviceName
                                    font.pixelSize: connectedDevicesTemplate.height / 2 - Style.padding.normal * 2
                                }
                                Loader {
                                    active: modelData.batteryAvailable
                                    sourceComponent: TextStyled {
                                        text: (modelData.battery * 100) + "%"
                                        font.pixelSize: connectedDevicesTemplate.height / 2 - Style.padding.normal * 2
                                    }
                                }
                            }
                        }

                        RowStyled {
                            anchors.verticalCenter: parent.verticalCenter
                            x: connectedDevicesTemplate.width - Style.padding.large - width
                            layoutDirection: Qt.RightToLeft

                            ButtonStyled {
                                height: connectedDevicesTemplate.height - Style.padding.large * 2
                                text: "Від'єднатися"
                                onClicked: modelData.disconnect()
                            }

                            ButtonStyled {
                                height: connectedDevicesTemplate.height - Style.padding.large * 2
                                text: "Налаштування"
                            }
                        }
                    }
                }
            }
        }

        RectForeground {
            id: avalibleDevicesContainer
            anchors.horizontalCenter: parent.horizontalCenter
            height: avalibleDevicesColumn.height + Style.padding.large * 2; width: root.width * 0.9

            ColumnStyled {
                id: avalibleDevicesColumn
                anchors.centerIn: parent

                TextStyled {text: "Доступні пристрої"}

                Repeater {
                    model: SBluetooth.avalibleDevices
                    delegate: Rect {
                        id: avalibleDevicesTemplate
                        height: 80
                        width: avalibleDevicesContainer.width - Style.padding.large * 2
                        clip: true
                        color: Theme.surfaceTop

                        RowStyled {
                            anchors.verticalCenter: parent.verticalCenter
                            x: Style.padding.normal

                            IconImage {
                                id: buttonIcon
                                source: SAppIcons.getIcon(modelData.icon)
                                implicitSize: avalibleDevicesTemplate.height - Style.padding.normal * 2
                            }

                            TextStyled {
                                text: modelData.name || modelData.deviceName
                                font.pixelSize: avalibleDevicesTemplate.height / 2 - Style.padding.normal * 2
                            }
                        }

                        ButtonStyled {
                            anchors.verticalCenter: parent.verticalCenter
                            x: avalibleDevicesTemplate.width - Style.padding.large - width
                            height: avalibleDevicesTemplate.height - Style.padding.large * 2
                            text: "Під'єднатися"
                            onClicked: modelData.connect()
                        }
                    }
                }
            }
        }
    }
}