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

    readonly property int textLength: 100
    readonly property int scrollDistance: textLength + Theme.spacing.normal

    // readonly property real firstTextY: isHorizontal ? 0 / 2 : root.height
    // readonly property real firstTextX: isHorizontal ? 0 : (root.width - implicitHeight) / 2
    // readonly property real containerX: isHorizontal ? 0 : 120

    onTextChanged: {
        anim.stop()

        // textContainer.y = firstTextY
        // textContainer.x = firstTextX
        // textContainer.y = Qt.binding(() => isHorizontal ? textLength * 2 : 0)
        // textContainer.x = Qt.binding(() => isHorizontal ? 0 : (root.width - textContainer.width) / 2)

        if (runText)
            anim.start()
    }

    Item {
        id: textContainer
        height: isHorizontal ? root.height : root.width
        width: isHorizontal ? root.width : root.height
        rotation: isHorizontal ? 0 : 270
        transformOrigin: Item.Center

        RectActive {
            id: firstText
            height: isHorizontal ? root.height : root.width
            width: 100
            opacity: 0.5
        }

        RectActive {
            height: isHorizontal ? root.height : root.width
            width: 100
            anchors {
                left: firstText.right
                leftMargin: Theme.spacing.normal
            }
            opacity: 0.5
        }

        // TextRunn {
        //     id: firstText
        // }

        // TextRunn {
        //     id: secondText
        //     anchors {
        //         left: firstText.right
        //         leftMargin: Theme.spacing.normal
        //     }
        // }
    }

    SequentialAnimation {
        id: anim
        running: runText
        loops: Animation.Infinite

        PauseAnimation {duration: Theme.durations.slow * 1}

        NumberAnimation {
            target: textContainer
            property: isHorizontal ? "x" : "y"
            from: 0
            to: isHorizontal ? -scrollDistance : scrollDistance
            easing.type: Easing.Linear
            duration: Math.max(1, (scrollDistance / scrollSpeed) * Theme.durations.slow)
        }
    }

    component TextRunn: TextStyled {
        text: root.text
        anchors.verticalCenter: isHorizontal ? parent.verticalCenter : undefined
        anchors.horizontalCenter: isHorizontal ? undefined : parent.horizontalCenter
    }
}