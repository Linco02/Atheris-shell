import QtQuick
import Quickshell
import qs.components
import qs.components.shapes
import qs.config
import qs.services


RectForeground {
    id: root

    property int today: TimeServices.today

    Column {
        anchors.centerIn: parent

        TextStyled {
            anchors.horizontalCenter: parent.horizontalCenter
            text: TimeServices.mounth
        }

        GridView {
            height: cellHeight; width: cellWidth * 7
            cellHeight: cellWidth; cellWidth: root.width / 8
            
            model: ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Нд"]
            delegate: Item {
                width: 35
                height: 35

                TextStyled {
                    anchors.centerIn: parent
                    text: modelData
                }
            }
        }

        GridView {
            height: cellHeight * 6; width: cellWidth * 7
            cellHeight: cellWidth; cellWidth: root.width / 8
            
            model: TimeServices.getCalendarDays()
            delegate: Rectangle {
                width: 35
                height: 35
                color: (modelData.day === today && modelData.isCurrent) ? Colors.surface : "transparent"
                radius: Global.radius.normal

                TextStyled {
                    anchors.centerIn: parent
                    text: modelData.day
                    color: {
                        if (modelData.day === today && modelData.isCurrent) return Colors.textAccent;
                        return modelData.isCurrent ? Colors.textSurface : Colors.textInactive;
                    }
                }
            }
        }
    }
}