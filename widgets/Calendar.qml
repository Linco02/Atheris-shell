import QtQuick
import Quickshell
import qs.components
import qs.singletons
import qs.settings

RectForeground {
    id: calendarWidget
    property int today: new Date().getDate()

    Column {
        anchors.centerIn: parent

        // Сітка назв днів
        GridView {
            height: cellHeight; width: cellWidth * 7
            cellHeight: cellWidth; cellWidth: calendarWidget.width / 8
            
            model: ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Нд"]
            delegate: Item {
                width: 35
                height: 35

                TextStyle1 {
                    anchors.centerIn: parent
                    text: modelData
                }
            }
        }

        // Сітка чисел
        GridView {
            height: cellHeight * 6; width: cellWidth * 7
            cellHeight: cellWidth; cellWidth: calendarWidget.width / 8
            
            model: CalendarInit.getCalendarDays()
            delegate: Item {
                width: 35
                height: 35
                
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 2
                    color: (modelData.day === today && modelData.isCurrent) ? Style.backGround : "transparent"
                    radius: Style.radius / 2
                }

                TextStyle1 {
                    anchors.centerIn: parent
                    text: modelData.day
                    color: {
                        if (modelData.day === today && modelData.isCurrent) return Style.activeTextColor;
                        return modelData.isCurrent ? Style.textColor : Style.inactiveTextColor;
                    }
                }
            }
        }
    }
}