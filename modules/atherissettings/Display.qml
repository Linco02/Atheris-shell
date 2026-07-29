import QtQuick
import qs.components
import qs.components.shapes
import qs.services
import qs.config

Item {
    id: root
    height: parent.height; width: parent.width

    property var displays: DisplayServices.displays

    Column {

        RectForeground {
            height: displayView.height; width: displayView.width

            Row {
                id: displayView
                spacing: 10

                Repeater {
                    model: displays
                    delegate: Rect {
                        height: modelData.physicalHeight
                        width: modelData.physicalWidth
                        color: modelData.focused ? Colors.inactive : Colors.active
                        
                        TextStyled {
                            text: modelData.activeWorkspace.name
                        }
                        Component.onCompleted: {console.log(modelData.name)}
                    }
                }
            }
        }
    }

}