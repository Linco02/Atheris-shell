import QtQuick
import qs.config
import qs.components
import qs.components.containers
import qs.components.animations

RowStyled {
    id: root

    property bool runText: false
    property bool isTextFit: root.width > textLength
    property string text: ""
    property int scrollDistance: textLength + Style.padding.normal
    property int scrollSpeed: 50
    property int textLength: firstText.width

    onTextChanged: x = 0

    TextStyled {
        id: firstText
        text: root.text
    }

    TextStyled {
        visible: !isTextFit
        text: root.text
    }

    SequentialAnimation on x {
        running: !isTextFit && runText
        loops: Animation.Infinite
        alwaysRunToEnd: true

        PauseAnimation {duration: Style.durations.slow * 5}

        NumberAnimation {
            from: 0
            to: -scrollDistance
            easing.type: Easing.Linear
            duration: (scrollDistance / scrollSpeed) * Style.durations.slow
        }
    }
}