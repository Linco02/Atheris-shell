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
        spacing: Global.spacing.normal

        GliphOwn { type: 0 }
        GliphOwn { type: 1 }
        GliphOwn { type: 2 }
    }

    component GliphOwn: Column {
        anchors.verticalCenter: parent.verticalCenter
        spacing: Global.spacing.normal

        property int type: 0
        property real percent: type === 0 ? PerfomanceServices.cpu[0]
            : type === 1 ? PerfomanceServices.gpu[0]
            : PerfomanceServices.mem[0]

        RectInactive {
            anchors.horizontalCenter: parent.horizontalCenter
            height: root.height - name.height - Global.spacing.large * 2
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