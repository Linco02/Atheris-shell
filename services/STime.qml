pragma Singleton
import QtQuick
import Quickshell
import qs.config

Singleton {
    property string time: ""
    property string date: ""
    property int today: new Date().getDate()
    property string mounth: Qt.formatDateTime(new Date(), "MMMM")
    property int dayStart: 0
    property int dayEnd: 0
    property bool isDay: {
        let hour = parseInt(time.split(":")[0])
        return hour >= dayStart && hour <= dayEnd
    }

    function clockUpdate() {
        let currentDate = new Date()
        date = Qt.formatDateTime(currentDate, "dd/MM/yyyy")
        time = Qt.formatTime(currentDate, "hh:mm")
    }

    function dayCycleInit() {
        let month = parseInt(date.split("/")[1])
        
        if (month >= 2 && month <= 4) { // Весна (Березень - Травень)
            dayStart = 6
            dayEnd = 19
        } else if (month >= 5 && month <= 7) { // Літо (Червень - Серпень)
            dayStart = 5
            dayEnd = 21
        } else if (month >= 8 && month <= 10) { // Осінь (Вересень - Листопад)
            dayStart = 7
            dayEnd = 18
        } else { // Зима (Грудень, Січень, Лютий)
            dayStart = 8
            dayEnd = 16
        }
    }

    function getCalendarDays() {
        let date = new Date();
        let year = date.getFullYear();
        let month = date.getMonth();
        let firstDay = new Date(year, month, 1);
        let daysInMonth = new Date(year, month + 1, 0).getDate();
        let startOffset = firstDay.getDay();
        startOffset = (startOffset === 0) ? 6 : startOffset - 1;
        let prevMonthLastDay = new Date(year, month, 0).getDate();
        let days = [];

        for (let i = startOffset; i > 0; i--) {
            days.push({ 
                day: prevMonthLastDay - i + 1, 
                isCurrent: false 
            });
        }
        for (let i = 1; i <= daysInMonth; i++) {
            days.push({ 
                day: i, 
                isCurrent: true 
            });
        }
        let nextDays = 42 - days.length;
        for (let i = 1; i <= nextDays; i++) {
            days.push({ 
                day: i, 
                isCurrent: false 
            });
        }

        return days;
    }

    Connections {
        target: Tick30s
        function onTick() { 
            clockUpdate()
        }
    }

    Component.onCompleted: {
        dayCycleInit()
        getCalendarDays()
    }
}