import QtQuick
import qs.config
import qs.components
import qs.components.animations

TextInput {
    color: Theme.textSurface
    font.family: Style.fontFamily
    font.weight: 600
    autoScroll: false
    clip: true
    verticalAlignment: TextInput.AlignVCenter

    property string placeholderText: ""

    signal entered()
    signal exited()

    TextStyled {
        anchors.centerIn: parent
        visible: parent.text === ""
        text: placeholderText
    }

    Keys.onReturnPressed: entered()
    Keys.onEscapePressed: exited()

    Behavior on color { ColorAnim {} }
}