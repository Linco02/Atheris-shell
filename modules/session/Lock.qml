import QtQuick
import QtQuick.Effects
import Quickshell.Wayland
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

WlSessionLock {
    locked: Global.isSessionLock

    WlSessionLockSurface {
        id: lockSurface
        color: Colors.surface

        SmartView {
            anchors.fill: parent
            content: Global.wallpaperCurrent
            isPlay: Global.isSessionLock

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
                    text: TimeServices.time
                    font.pixelSize: 60
                }

                OwnText {
                    text: TimeServices.date
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
                TapHandler { onTapped: Global.isSessionLock = false }
            }

            RowSpaced {
                anchors.horizontalCenter: parent.horizontalCenter
                
                Repeater {
                    model: SessionServices.actions.filter(a => a.command !== null)

                    ButtonStyled {
                        height: 40; width: height
                        text: modelData.icon
                        onClicked: SessionServices.choseAction(modelData)
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
    }

    component OwnText: TextStyled {
        anchors.horizontalCenter: parent.horizontalCenter
        color: Colors.textAccent
    }
}