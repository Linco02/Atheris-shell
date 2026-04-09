import QtQuick
import qs.components
import qs.components.shapes
import qs.components.popups
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

PopFade {
    id: root
    containerH: powerContainer.height
    containerW: powerContainer.width
    positionX: panel.width - root.width - Global.padding.normal
    isOpen: Global.isControlCenterOpen
    onClosedPop: Global.isControlCenterOpen = false
    isLeft: false

    property int buttonW: 40

    ColumnSpaced {
        id: powerContainer

        Repeater {
            model: SessionServices.actions

            Rect {
                id: button
                height: 30; width: buttonW + Global.padding.normal

                RowSpaced {
                    id: rowButton
                    anchors.left: parent.left

                    ButtonStyled {
                        height: button.height; width: height
                        text: modelData.icon
                        radius: button.radius - 5
                        onLeftClicked: SessionServices.choseAction(modelData)
                    }

                    TextStyled {
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData.label
                    }
                }

                Component.onCompleted: {
                    if (rowButton.width > buttonW)
                        buttonW = rowButton.width
                }
            }
        }
    }
}