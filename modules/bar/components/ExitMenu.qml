import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.config
import qs.components.animations
import qs.components.containers
import qs.components.shapes
import qs.components

PopFlash {
    anchor {
        window: root
        rect.x: Appearance.padding.normal
        rect.y: root.height + Appearance.padding.normal
    }
    implicitHeight: 900; implicitWidth: 500

    property var list: [ "", "", "󰤄", "󰚭" ]
    property var listText: [ "Вимкнути", "Перезавантажити", "Сон", "Гібернація" ]

    function choseProcess(index) {
        console.log("yes")
        if (index === 0)
            poweroffProcess.running = true
        else if (index === 1)
            rebootProcess.running = true
        else if (index === 2)
            suspendProcess.running = true
        else if (index === 3)
            hibernateProcess.running = true
    }

    Process { id: poweroffProcess; command: ["systemctl", "poweroff"] }
    Process { id: rebootProcess; command: ["systemctl", "reboot"] }
    Process { id: suspendProcess; command: ["systemctl", "suspend"] }
    Process { id: hibernateProcess; command: ["systemctl", "hibernate"] }   

    Column {
        spacing: 10

        Repeater {
            model: list

            Rect {
                height: childrenRect.height; width: childrenRect.width

                RowNormal {
                    rightPadding: 10

                    RectOwn {
                        id: button
                        TextOwn { text: modelData }
                        Behavior on color { ColorAnim { } }
                    }

                    TextStyled {
                        id: description
                        anchors.verticalCenter: parent.verticalCenter
                        text: listText[index]
                        Behavior on color { ColorAnim { } }
                    }
                }

                MouseFill {
                    hoverEnabled: true
                    onClicked: choseProcess(index)
                    onEntered: {
                        parent.color = Colors.surfaceRaised
                        button.color = Colors.active
                        description.color = Colors.textAccent
                    }
                    onExited: {
                        parent.color = "transparent"
                        button.color = Colors.surface
                        description.color = Colors.textSurface
                    }
                }

                Behavior on color { ColorAnim { } }
            }
        }
    }
    
    component RectOwn: RectForeground {
        height: width; width: 40
    }

    component TextOwn: TextStyled {
        anchors.centerIn: parent
    }
}