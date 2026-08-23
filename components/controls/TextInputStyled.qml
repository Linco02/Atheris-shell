import QtQuick
import qs.config
import qs.components
import qs.components.shapes
import qs.components.animations

RectForeground {
    id: root

    property string beforeText: ""
    property alias inputFocus: textInput.focus
    property string placeholderText: ""
    property string enteredText: textInput.text

    signal entered()
    signal exited()

    TextStyledB {
        id: textBefore
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: Style.padding.normal
        }
        text: beforeText
    }

    TextInput {
        id: textInput
        anchors {
            right: parent.right
            rightMargin: Style.padding.normal
        }
        height: root.height
        width: root.width - textBefore.width - Style.padding.normal * 3
        font {
            family: Style.fontFamily
            weight: 600
        }
        color: Theme.textSurface
        autoScroll: false
        clip: true
        verticalAlignment: TextInput.AlignVCenter

        TextStyled {
            anchors.centerIn: parent
            visible: parent.text === ""
            text: placeholderText
        }

        Keys.onReturnPressed: entered()
        Keys.onEscapePressed: exited()

        Behavior on color {ColorAnim {}}

        Component.onCompleted: forceActiveFocus()
    }
}