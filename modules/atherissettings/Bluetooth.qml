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
                    text: STranslations.tr("bluetooth")
                }
                ButtonToggle {
                    id: toggle
                    height: name.height
                    isActive: SBluetooth?.isBluetoothOn
                    onClicked: SBluetooth.toggleBluetooth()
                }

                TextStyledB {width: name.width; text: STranslations.tr("scanning")}
                ButtonToggle {
                    height: toggle.height
                    isActive: adapter?.discovering
                    onClicked: SBluetooth.toggleDiscovering()
                }

                TextStyledB {width: name.width; text: STranslations.tr("bluetooth_discoverable")}
                ButtonToggle {
                    height: toggle.height
                    isActive: adapter?.discoverable
                    onClicked: SBluetooth.toggleDiscoverable()
                }

                TextStyledB {width: name.width; text: STranslations.tr("bluetooth_pairable")}
                ButtonToggle {
                    height: toggle.height
                    isActive: adapter?.pairable
                    onClicked: SBluetooth.togglePairable()
                }
            }
        }

        TextStyled {leftPadding: Style.padding.large; text: STranslations.tr("paired_devices")}

        Repeater {
            model: SBluetooth?.pairedDevices
            delegate: RectForeground {
                id: pairedDevicesTemplate
                height: 100; width: parent.width
                clip: true
                color: isConnect ? Theme.active : Theme.surfaceRaised

                property bool isConnect: modelData.connected

                RowStyled {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: Style.padding.large
                    }

                    IconImage {
                        id: buttonIcon
                        source: SIcon.getIcon(modelData.icon)
                        implicitSize: pairedDevicesTemplate.height - Style.padding.large * 2
                    }

                    ColumnStyled {
                        anchors.verticalCenter: parent.verticalCenter

                        TextStyledB {
                            text: modelData.name || modelData.deviceName
                            color: isConnect ? Theme.textAccent : Theme.textSurface
                        }
                        Loader {
                            active: modelData.batteryAvailable
                            sourceComponent: TextStyledB {
                                color: isConnect ? Theme.textAccent : Theme.textSurface
                                text: Math.floor(modelData.battery * 100) + "%"
                            }
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
                        text: modelData.connected
                            ? STranslations.tr("disconnect")
                            : STranslations.tr("connect")
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

        TextStyled {
            leftPadding: Style.padding.large
            text: STranslations.tr("available_devices")
        }

        Repeater {
            model: SBluetooth?.availableDevices
            delegate: RectForeground {
                id: availableDevicesTemplate
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
                        source: SIcon.getIcon(modelData.icon)
                        implicitSize: availableDevicesTemplate.height - Style.padding.large * 2
                    }

                    TextStyledB {text: modelData.name || modelData.deviceName}
                }

                ButtonStyled {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: Style.padding.large
                    }
                    height: availableDevicesTemplate.height - Style.padding.large * 2
                    text: STranslations.tr("connect")
                    fontSize: Theme.fontSize * 1.6
                    onClicked: modelData.connect()
                }
            }
        }
    }
}