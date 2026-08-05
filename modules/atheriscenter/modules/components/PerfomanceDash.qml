import QtQuick
import qs.components
import qs.components.shapes
import qs.components.animations
import qs.config
import qs.services

RectForeground {
    id: root

    Row {
        anchors.centerIn: parent
        spacing: Style.spacing.normal

        GliphOwn { type: 0 }
        GliphOwn { type: 1 }
        GliphOwn { type: 2 }
    }

    component GliphOwn: Column {
        anchors.verticalCenter: parent.verticalCenter
        spacing: Style.spacing.normal

        property int type: 0
        property real percent: type === 0 ? SPerfomance.cpu[0]
            : type === 1 ? SPerfomance.gpu[0]
            : SPerfomance.mem[0]

        RectInactive {
            anchors.horizontalCenter: parent.horizontalCenter
            height: root.height - name.height - Style.spacing.large * 2
            width: 20
            
            RectActive {
                anchors.bottom: parent.bottom
                height: parent.height * percent
                width: parent.width

                Behavior on height { NumberAnim { } }
            }
        }

        TextStyled {
            id: name
            anchors.horizontalCenter: parent.horizontalCenter
            text: type === 0 ? ""
                : type === 1 ? "󰢮"
                : ""
        }
    }
}