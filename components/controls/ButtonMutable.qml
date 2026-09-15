import QtQuick
import qs.config
import qs.components
import qs.components.shapes

RectInactive {
    id: root

    property var buttons: []
    property var buttonsNames: []
    property string activeButton: ""
    signal clicked()

    Row {
        Repeater {
            model: buttons.length

            delegate: RectInactive {
                height: root.height; width: root.width / buttons.length
                color: isActive
                    ? Theme.colors.active
                    : Theme.colors.inactive
                
                property bool isActive: activeButton === buttons[modelData]

                TextStyled {
                    anchors.centerIn: parent
                    text: buttonsNames[modelData] || buttons[modelData]
                    color: isActive
                        ? Theme.colors.textAccent
                        : Theme.colors.textSurface
                }

                TapHandler {
                    onTapped: {
                        activeButton = buttons[modelData]
                        clicked()
                    }
                }
            }
        }
    }
}