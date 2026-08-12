import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

ColumnStyled {
    id: root
    anchors.fill: parent

    RowStyled {
        width: parent.width
        layoutDirection: Qt.RightToLeft

        ButtonToggle {
            id: button
            height: 30
            onClicked: SBluetooth.bluetoothToggle()
            isActive: SBluetooth.isBluetoothOn
        }
        
        ButtonStyled {
            id: refreshBtn
            height: 30; width: height
            text: ""
            onClicked: SBluetooth.adapter.discovering = !SBluetooth.adapter.discovering

            NumberAnimation on rotation {
                id: spinAnimation
                running: false
                from: 0
                to: 360
                duration: 1500
                easing.type: Easing.Linear
                loops: 1

                onFinished: {
                    refreshBtn.rotation = 0
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
    }


    RectForeground {
        height: root.height - button.height; width: root.width

        ScrollView {
            anchors.fill: parent
            contentWidth: -1
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            
            ColumnStyled {
                topPadding: Style.padding.normal
                
                TextStyled {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Під'єднані пристрої"
                }

                Repeater {
                    model: SBluetooth.connectedDevices
                    
                    delegate: RectInactive {
                        height: 40; width: root.width

                        RowStyled {
                            anchors.verticalCenter: parent.verticalCenter
                            leftPadding: Style.padding.normal

                            TextStyled {
                                text: modelData.name
                            }

                            TextStyled {
                                text: modelData.connected
                            }
                        }
                        
                        TapHandler {onTapped: modelData.disconnect()}
                    }
                }

                TextStyled {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Доступні пристрої"
                }

                Repeater {
                    model: SBluetooth.avalibleDevices

                    delegate: RectInactive {
                        height: 40; width: root.width

                        RowStyled {
                            anchors.verticalCenter: parent.verticalCenter
                            leftPadding: Style.padding.normal

                            TextStyled {
                                text: modelData.name
                            }

                            TextStyled {
                                text: modelData.connected
                            }
                        }

                        TapHandler {onTapped: modelData.connect()}
                    }
                }
            }
        }
    }
}