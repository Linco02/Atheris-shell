import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

ScrollStyled {
    padding: Style.padding.normal

    ColumnStyled {
        width: parent.width

        Item {
            height: 30; width: parent.width

            ButtonStyled {
                anchors.left: parent.left
                height: parent.height; width: height
                text: ""
                onClicked: SWManager.controlCenter("main")
            }

            ButtonStyled {
                anchors {
                    right: bluetoothToggle.left
                    rightMargin: Style.margine.normal
                }
                height: parent.height; width: height
                text: ""
                onClicked: SBluetooth.toggleDiscovering()

                NumberAnimation on rotation {
                    id: spinAnimation
                    running: false
                    from: 0; to: 360
                    duration: 1500
                    loops: 1
                    easing.type: Easing.Linear

                    onFinished: {
                        parent.rotation = 0
                        if (SBluetooth.adapter.discovering) {
                            spinAnimation.start()
                        }
                    }
                }

                Connections {
                    target: SBluetooth.adapter
                    function onDiscoveringChanged() {
                        if (SBluetooth.adapter.discovering && !spinAnimation.running) {
                            spinAnimation.start()
                        }
                    }
                }
            }

            ButtonToggle {
                id: bluetoothToggle
                anchors.right: parent.right
                height: parent.height
                onClicked: SBluetooth.toggleBluetooth()
                isActive: SBluetooth.isBluetoothOn
            }
        }

        TextStyled {
            text: "Сполучені пристрої"
            leftPadding: Style.padding.normal
        }

        Repeater {
            model: SBluetooth.pairedDevices
            delegate: DeviceButton {}
        }

        TextStyled {
            text: "Доступні пристрої"
            leftPadding: Style.padding.normal
        }

        Repeater {
            model: SBluetooth.availableDevices
            delegate: DeviceButton {}
        }
    }

    component DeviceButton: ButtonCompound {
        height: 40; width: parent.width
        icon: modelData?.icon
        textTop: modelData?.deviceName
        textBottom: SBluetooth?.getDeviceStatus(modelData)
        isActive: modelData?.connected
        onClicked: modelData?.connected ? modelData.disconnect()
            : modelData.connect()
    }
}