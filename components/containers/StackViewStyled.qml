import QtQuick
import QtQuick.Controls

StackView {
    id: stack
    anchors.fill: parent
    // height: currentItem ? currentItem.implicitHeight : 200
    // width: currentItem ? currentItem.implicitWidth : 200
    
    property int gap: 20 // Твій відступ

    pushEnter: Transition {
        PropertyAnimation {
            property: "x"
            from: stack.width + stack.gap // Починаємо далі, ніж край екрана
            to: 0
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    pushExit: Transition {
        PropertyAnimation {
            property: "x"
            from: 0
            to: -stack.width - stack.gap // Виходимо за межі з запасом
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
}