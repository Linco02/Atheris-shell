import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.config
import qs.services
import qs.components.animations
import qs.components.containers
import qs.components.shapes
import qs.components
import qs.modules.lock

PopFlash {
    anchor {
        window: root
        rect.y: root.height + Appearance.padding.normal
        rect.x: Appearance.padding.normal
    }
    implicitHeight: 900; implicitWidth: 500

    property bool isLeft: true

    Column {
        spacing: 10

        Repeater {
            model: [ "Вимкнути", "Перезавантажити", "Сон", "Гібернація", "Заблокувати" ]

            Rect {
                height: childrenRect.height; width: childrenRect.width

                RowNormal {
                    rightPadding: 10

                    RectForeground {
                        id: button
                        height: width; width: 40

                        TextStyled {
                            anchors.centerIn: parent
                            text: Exit.iconList[modelData]
                        }

                        Behavior on color { ColorAnim { } }
                    }

                    TextStyled {
                        id: description
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData

                        Behavior on color { ColorAnim { } }
                    }
                }

                MouseFill {
                    hoverEnabled: true
                    onClicked: Exit.choseProcess(modelData)
                    onEntered: {
                        parent.color = Colors.surfaceRaised
                        button.color = Colors.active
                        description.color = Colors.textAccent
                    }
                    onExited: {
                        parent.color = "transparent"
                        button.color = Colors.surfaceRaised
                        description.color = Colors.textSurface
                    }
                }

                Behavior on color { ColorAnim { } }
            }
        }
    }
}