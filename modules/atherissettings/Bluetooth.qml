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

    property var adapter: SBluetooth?.adapter

    ColumnStyled {
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height
        width: root.width * 0.9

        TextStyled {leftPadding: Style.padding.large; text: adapter?.name || ""}

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
                    text: "Bluetooth"
                }
                ButtonToggle {
                    id: toggle
                    height: name.height
                    isActive: SBluetooth?.isBluetoothOn
                    onClicked: SBluetooth.bluetoothToggle()
                }

                TextStyledB {width: name.width; text: "Сканування пристроїв"}
                ButtonToggle {
                    height: toggle.height
                    isActive: adapter?.discovering
                    onClicked: SBluetooth.discoveringToggle()
                }

                TextStyledB {width: name.width; text: "Виявлення іншими пристроями"}
                ButtonToggle {
                    height: toggle.height
                    isActive: adapter?.discoverable
                    onClicked: SBluetooth.discoverableToogle()
                }

                TextStyledB {width: name.width; text: "Дозволено сполучення іншим пристроям"}
                ButtonToggle {
                    height: toggle.height
                    isActive: adapter?.pairable
                    onClicked: SBluetooth.pairableTggle()
                }
            }
        }

        TextStyled {leftPadding: Style.padding.large; text: "Сполучені пристрої"}

        Repeater {
            model: SBluetooth?.pairedDevices
            delegate: RectForeground {
                id: pairedDevicesTemplate
                height: 100; width: parent.width
                clip: true

                RowStyled {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: Style.padding.large
                    }

                    IconImage {
                        id: buttonIcon
                        source: SAppIcons.getIcon(modelData.icon)
                        implicitSize: pairedDevicesTemplate.height - Style.padding.large * 2
                    }

                    ColumnStyled {
                        anchors.verticalCenter: parent.verticalCenter

                        TextStyledB {
                            text: modelData.name || modelData.deviceName
                            color: modelData.connected ? Theme.textAccent : Theme.textSurface
                        }
                        Loader {
                            active: modelData.batteryAvailable
                            sourceComponent: TextStyledB {text: (modelData.battery * 100) + "%"}
                        }
                    }
                }

                RowStyled {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: Style.padding.large
                    }

                    ButtonStyled {
                        height: pairedDevicesTemplate.height - Style.padding.large * 2
                        text: modelData.connected ? "Від'єднатися" : "Під'єднатися"
                        fontSize: Theme.fontSize * 1.6
                        onClicked: modelData.connected ? modelData.disconnect() : modelData.connect()
                    }

                    ButtonStyled {
                        height: pairedDevicesTemplate.height - Style.padding.large * 2
                        width: height
                        text: ""
                        fontSize: Theme.fontSize * 1.6
                    }
                }
            }
        }

        TextStyled {leftPadding: Style.padding.large; text: "Доступні пристрої"}

        Repeater {
            model: SBluetooth?.avalibleDevices
            delegate: RectForeground {
                id: avalibleDevicesTemplate
                height: 100; width: parent.width
                clip: true

                RowStyled {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: Style.padding.large
                    }

                    IconImage {
                        id: buttonIcon
                        source: SAppIcons.getIcon(modelData.icon)
                        implicitSize: avalibleDevicesTemplate.height - Style.padding.large * 2
                    }

                    TextStyledB {text: modelData.name || modelData.deviceName}
                }

                ButtonStyled {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: Style.padding.large
                    }
                    height: avalibleDevicesTemplate.height - Style.padding.large * 2
                    text: "Під'єднатися"
                    fontSize: Theme.fontSize * 1.6
                    onClicked: modelData.connect()
                }
            }
        }
    }
}