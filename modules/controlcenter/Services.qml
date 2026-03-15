import QtQuick
import qs.config
import qs.components.shapes
import qs.components

RectForeground {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter
    height: container.height
    width: parent.width

    Row {
        id: container
        width: parent.width - Appearance.padding.large
        spacing: 10
        padding: 10

        RectBlock {

            // TextStyled {
            //     text: "test"
            //     color: "red"
            // }
        }

        RectBlock {

            TextStyled {
                text: "test"
                color: "red"
            }
        }
    }

    component RectBlock: RectInactive{
        radius: root.radius - parent.spacing
        height: 50; width: root.width / 2 - parent.spacing * 3 / 2
    }
}