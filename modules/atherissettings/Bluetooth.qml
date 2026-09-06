import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.components.controls
import qs.services
import qs.config

ColumnStyled {
    id: root
    anchors.fill: parent

    property var adapter: SBluetooth?.adapter

    TextStyled {leftPadding: Style.padding.large; text: adapter?.name || ""}

    RectForeground {
        id: settingsContainer
        height: wifiSettings.height; width: parent.width
        clip: true

        ColumnStyled {
            id: wifiSettings
            width: parent.width
            padding: Style.padding.large

            Repeater {
                model: [
                    {label: "bluetooth", settingKey: "enabled", actionName: "toggleBluetooth"},
                    {label: "scanning", settingKey: "discovering", actionName: "toggleDiscovering"},
                    {label: "bluetooth_discoverable", settingKey: "discoverable", actionName: "toggleDiscoverable"},
                    {label: "bluetooth_pairable", settingKey: "pairable", actionName: "togglePairable"}
                ]

                delegate: ButtonLabelToggle {
                    text: STranslations.tr(modelData.label)
                    isActive: SBluetooth.adapter[modelData.settingKey]
                    onClicked: SBluetooth[modelData.actionName]()
                }
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