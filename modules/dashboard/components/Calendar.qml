import QtQuick
import Quickshell
import qs.config
import qs.services
import qs.components.shapes
import qs.components

RectForeground {
    id: calendarWidget
    property int today: new Date().getDate()
    property string mounth: Qt.formatDateTime(new Date(), "MMMM")

    Column {
        anchors.centerIn: parent

        TextStyled {
            anchors.horizontalCenter: parent.horizontalCenter
            text: mounth
        }

        // Сітка назв днів
        GridView {
            height: cellHeight; width: cellWidth * 7
            cellHeight: cellWidth; cellWidth: calendarWidget.width / 8
            
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
                    color: (modelData.day === today && modelData.isCurrent) ? Appearance.surface : "transparent"
                    radius: Appearance.radius.normal
                }

                TextStyled {
                    anchors.centerIn: parent
                    text: modelData.day
                    color: {
                        if (modelData.day === today && modelData.isCurrent) return Appearance.textAccent;
                        return modelData.isCurrent ? Appearance.textSurface : Appearance.textInactive;
                    }
                }
            }
        }
    }
}