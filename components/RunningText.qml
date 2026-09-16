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
    property int textLength: firstText.width
    property int scrollSpeed: 50
    readonly property int scrollDistance: textLength + Theme.padding.normal

    onTextChanged: {
        anim.stop()
        x = 0
        if (!isTextFit && runText) {
            anim.start()
        }
    }

    TextStyled {
        id: firstText
        text: root.text
    }

    TextStyled {
        visible: !isTextFit
        text: root.text
    }

    SequentialAnimation on x {
        id: anim
        running: !isTextFit && runText
        loops: Animation.Infinite

        PauseAnimation {duration: Theme.durations.slow * 1}

        NumberAnimation {
            from: 0
            to: -scrollDistance
            easing.type: Easing.Linear
            duration: Math.max(1, (scrollDistance / scrollSpeed) * Theme.durations.slow)
        }
    }
}