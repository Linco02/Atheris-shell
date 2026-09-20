import QtQuick
import qs.config
import qs.components
import qs.components.containers
import qs.components.animations

import qs.components.shapes

Item {
    id: root

    property bool isHorizontal: true
    property bool runText: false
    property int scrollSpeed: 50
    property string text: ""

    readonly property int textLength: firstText.width
    readonly property int scrollDistance: textLength + Theme.spacing.normal

    onTextChanged: {
        anim.stop()
        firstText.x = textLength * 2
        if (runText)
            anim.start()
    }

    Item {
        id: textContainer
        anchors.centerIn: parent
        width: root.isHorizontal ? root.width : root.height
        height: root.isHorizontal ? root.height : root.width
        rotation: isHorizontal ? 0 : 270
        transformOrigin: Item.Center

        TextRunn {
            id: firstText
        }

        TextRunn {
            id: secondText
            anchors {
                left: firstText.right
                leftMargin: Theme.spacing.normal
            }
        }
    }

    SequentialAnimation {
        id: anim
        running: runText
        loops: Animation.Infinite

        PauseAnimation {duration: Theme.durations.slow * 1}

        NumberAnimation {
            target: firstText
            property: "x"
            from: 0
            to: -scrollDistance
            easing.type: Easing.Linear
            duration: Math.max(1, (scrollDistance / scrollSpeed) * Theme.durations.slow)
        }
    }

    component TextRunn: TextStyled {
        text: root.text
        anchors.verticalCenter: parent.verticalCenter
    }
}