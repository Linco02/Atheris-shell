import QtQuick
import qs.components
import qs.config

Item {
    id: root

    property real relationship: 0.5

    property string text: ""
    property int margine: 0

    property alias beforeText: textInput.beforeText
    property alias inputFocus: textInput.inputFocus
    property alias placeholderText: textInput.placeholderText
    property alias enteredText: textInput.enteredText

    signal entered()
    signal exited()

    TextStyled {
        anchors {
            left: root.left
            leftMargin: root.margine
            verticalCenter: parent.verticalCenter
        }
        height: root.height; width: root.width - textInput.width
        text: root.text
    }

    TextInputStyled {
        id: textInput
        anchors {
            right: root.right
            rightMargin: root.margine
            verticalCenter: parent.verticalCenter
        }
        height: root.height; width: root.width * relationship
        color: Theme.colors.inactive
    }
}