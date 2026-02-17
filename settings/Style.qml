pragma Singleton
import QtQuick

QtObject {
    // =======================
    // === загальні змінні ===
    // =======================

    // масштаб
    property real scale: 1

    // анімації
    property int spedAnim: 400
    
    // декорація
    property real radius: 15 * scale
    property real radius2: 20 * scale
    property real padding: 5 * scale
    property real padding2x: padding * 2
    property real spacing: 10 * scale

    // панелі
    property real topPanel: 34 * scale
    property real bottomPanel: 34 * scale
    property real leftPanel: 10 * scale
    property real rightPanel: 10 * scale

    // ======================
    // === Шрифт та текст ===
    // ======================

    property real fontSize: 12
    property string fontFamily: "FiraCode Nerd Font"

    // ===================================
    // === палітра кольорів та шпалери ===
    // ===================================

    // шпалери
    property var imagesList: []
    property url images: ""

    // згенерована палітра
    property color color1: "#031523"
    property color color2: "#151c2c"
    property color color3: "#484662"
    property color color4: "#4c6383"
    property color color5: "#655273"
    property color color6: "#635980"
    property color color7: "#755675"
    property color color8: "#d2778b"

    // колір елементів
    property color panelColor: color1
    property color backGround: color1
    property color foreGround: color2
    property color borderColor: color6
    property color activeColor: color6
    property color inactiveColor: color3
    property color warningColor: color8

    property color textColor: "white"

    property color activeTextColor: "#F0F8FF"
    property color inactiveTextColor: "#F0F8FF"
}

// #031523 (найтемніший)

// Фон панелі/бара
// Фон overlay меню (launcher, notification center)
// Фон tooltip'ів

// #151c2c (темно-синій)

// Фон воркспейсів (неактивних)
// Фон віджетів (годинник, календар, системні індикатори)
// Фон контекстних меню

// #484662 (темний фіолетово-сірий)

// Рамки вікон/панелей
// Розділювачі між модулями
// Неактивні іконки в треї

// #4c6383 (приглушений синій)

// Hover стан для воркспейсів
// Фон для secondary widgets (weather, music player controls)
// Неактивні кнопки

// #655273 (фіолетово-сірий)

// Текст вторинний (дата, системна інформація)
// Неактивні іконки
// Placeholder текст

// #635980 (синьо-фіолетовий)

// Активний воркспейс (border/background)
// Іконки в треї (активні застосунки)
// Hover стани для кнопок

// #755675 (теплий фіолетовий)

// Hover для інтерактивних елементів (кнопки, toggles)
// Прогрес-бари (volume, brightness) - заповнення
// Акценти на медіа-контролах

// #d2778b (рожевий)

// Критичні нотифікації
// Активне вікно індикатор
// Кнопки дій (shutdown, logout)
// Urgent workspace indicator
// Акценти на важливих системних статусах (battery critical, updates)