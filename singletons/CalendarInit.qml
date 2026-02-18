pragma Singleton
import QtQuick

QtObject {
    function getCalendarDays() {
        let date = new Date();
        let year = date.getFullYear();
        let month = date.getMonth();
        
        // Перший день поточного місяця
        let firstDay = new Date(year, month, 1);
        // Скільки днів у поточному місяці
        let daysInMonth = new Date(year, month + 1, 0).getDate();
        
        // Визначаємо зміщення для Пн (0 - Пн, 6 - Нд)
        let startOffset = firstDay.getDay();
        startOffset = (startOffset === 0) ? 6 : startOffset - 1;

        // Отримуємо останній день попереднього місяця
        let prevMonthLastDay = new Date(year, month, 0).getDate();

        let days = [];

        // 1. Заповнюємо хвіст попереднього місяця
        for (let i = startOffset; i > 0; i--) {
            days.push({ 
                day: prevMonthLastDay - i + 1, 
                isCurrent: false 
            });
        }

        // 2. Додаємо дні поточного місяця
        for (let i = 1; i <= daysInMonth; i++) {
            days.push({ 
                day: i, 
                isCurrent: true 
            });
        }

        // 3. Заповнюємо початок наступного місяця до повної сітки (42 дні)
        let nextDays = 42 - days.length;
        for (let i = 1; i <= nextDays; i++) {
            days.push({ 
                day: i, 
                isCurrent: false 
            });
        }

        return days;
    }
}
