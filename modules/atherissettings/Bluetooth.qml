import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.components.controls
import qs.services
import qs.config

Column {
    id: root
    anchors.fill: parent
    spacing: Theme.spacing.large

    property var adapter: SBluetooth?.adapter
    readonly property int unitSize: Theme.unitSize.normal

    TextStyled {leftPadding: Theme.padding.large; text: adapter?.name || ""}

    RectForeground {
        id: settingsContainer
        height: wifiSettings.height; width: parent.width
        clip: true

        ColumnStyled {
            id: wifiSettings
            width: parent.width
            padding: Theme.padding.large

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
                    height: unitSize
                    width: parent.width - Theme.margine.large * 2
                }
            }
        }
    }

    TextStyled {leftPadding: Theme.padding.large; text: STranslations.tr("paired_devices")}

    Repeater {
        model: SBluetooth?.pairedDevices
        delegate: RectForeground {
            id: pairedDevicesTemplate
            height: 100; width: parent.width
            clip: true
            color: isConnect ? Theme.colors.active : Theme.colors.surfaceRaised

            property bool isConnect: modelData.connected

            RowStyled {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: Theme.padding.large
                }

                IconImage {
                    id: buttonIcon
                    source: SIcon.getIcon(modelData.icon)
                    implicitSize: pairedDevicesTemplate.height - Theme.padding.large * 2
                }

                ColumnStyled {
                    anchors.verticalCenter: parent.verticalCenter

                    TextStyledB {
                        text: modelData.name || modelData.deviceName
                        color: isConnect ? Theme.colors.textAccent : Theme.colors.textSurface
                    }
                    Loader {
                        active: modelData.batteryAvailable
                        sourceComponent: TextStyledB {
                            color: isConnect ? Theme.colors.textAccent : Theme.colors.textSurface
                            text: Math.floor(modelData.battery * 100) + "%"
                        }
                    }
                }
            }

            RowStyled {
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: Theme.padding.large
                }

                ButtonStyled {
                    height: pairedDevicesTemplate.height - Theme.padding.large * 2
                    text: modelData.connected
                        ? STranslations.tr("disconnect")
                        : STranslations.tr("connect")
                    fontSize: Theme.fontSize * 1.6
                    onClicked: modelData.connected ? modelData.disconnect() : modelData.connect()
                }

                ButtonStyled {
                    height: pairedDevicesTemplate.height - Theme.padding.large * 2
                    width: height
                    text: ""
                    fontSize: Theme.fontSize * 1.6
                }
            }
        }
    }

    TextStyled {
        leftPadding: Theme.padding.large
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
                    leftMargin: Theme.padding.large
                }

                IconImage {
                    id: buttonIcon
                    source: SIcon.getIcon(modelData.icon)
                    implicitSize: availableDevicesTemplate.height - Theme.padding.large * 2
                }

                TextStyledB {text: modelData.name || modelData.deviceName}
            }

            ButtonStyled {
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: Theme.padding.large
                }
                height: availableDevicesTemplate.height - Theme.padding.large * 2
                text: STranslations.tr("connect")
                fontSize: Theme.fontSize * 1.6
                onClicked: modelData.connect()
            }
        }
    }
}