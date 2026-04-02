import QtQuick
import QtQuick.Controls
import qs.config
import qs.components.shapes
import qs.components

RectForeground {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter
    height: container.height
    width: parent.width

    property int panelH: 0
    property int panelW: 0

    Row {
        id: container
        width: parent.width - Appearance.padding.large
        spacing: 10
        padding: 10

        RectBlock {

            ButtonOwn { }


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

    RectInactive {
        id: munu
    }

    component RectBlock: RectInactive{
        radius: root.radius - parent.spacing
        height: 50; width: root.width / 2 - parent.spacing * 3 / 2
    }

    component ButtonOwn: Button {
        onClicked: {
            munu.height = root.panelH
            munu.width = root.panelW
        }
    }
}