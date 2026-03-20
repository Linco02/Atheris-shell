import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import qs.services
import qs.config
import qs.components.animations
import qs.components.shapes
import qs.components.containers
import qs.components

Item {
    Connections {
        target: GlobalStates
        function onIsSessionLockOnChanged() {
            lock.locked = GlobalStates.isSessionLockOn
        }
    }

    WlSessionLock {
        id: lock

        WlSessionLockSurface {
            color: Colors.surface

            Connections {
                target: Time
                function onTime(data) {
                    timeText.text = data
                }
            }

            Connections {
                target: Time
                function onDate(data) {
                    dateText.text = data
                }
            }

            Image {
                id: backgroundImage
                anchors.fill: parent
                source: Wallpapers.wallpaper

                layer.enabled: true
                layer.effect: MultiEffect {
                    blurEnabled: true
                    blurMax: 32
                    blur: 1.0
                }
            }

            Column {
                anchors.centerIn: parent
                spacing: 40

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    OwnText {
                        id: timeText
                        font.pixelSize: 60
                    }

                    OwnText {
                        id: dateText
                        font.pixelSize: 30
                    }
                }

                RectForeground {
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 40; width: 200
                    TextStyled {
                        anchors.centerIn: parent
                        text: "Розблокувати"
                    }
                    MouseFill { onClicked: GlobalStates.isSessionLockLock = false }
                }

                RowNormal {
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    Repeater {
                        model: ["Вимкнути", "Перезавантажити", "Сон", "Гібернація"]

                        RectForeground {
                            id: button
                            height: width; width: 40

                            TextStyled {
                                anchors.centerIn: parent
                                text: Exit.iconList[modelData]
                            }

                            MouseFill { onClicked: Exit.choseProcess(modelData) }

                            Behavior on color { ColorAnim { } }
                        }
                    }
                }
            }

            Column {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                }
                OwnText { text: "Atheris-shell | linco02" }
                OwnText { text: "github:Linco02/Atheris-shell" }
            }

            Component.onCompleted: {
                Time.clockUpdate()
            }
        }
    }

    component OwnText: TextStyled {
        anchors.horizontalCenter: parent.horizontalCenter
        color: Colors.textAccent
    }
}