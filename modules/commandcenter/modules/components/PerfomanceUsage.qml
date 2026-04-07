import QtQuick
import qs.components
import qs.components.shapes
import qs.components.indicators
import qs.config
import qs.services

RectForeground {
    id: root
    height: 240; width: 240

    property int type: 0
    property var info: {
        if (type === 0) return PerfomanceServices.cpu
        if (type === 1) return PerfomanceServices.gpu
        if (type === 2) return PerfomanceServices.mem
    }

    Column {
        anchors.centerIn: parent

        TextStyled {
            anchors.horizontalCenter: parent.horizontalCenter
            text: type === 0 ? "CPU"
                : type === 1 ? "GPU"
                : "MEM"
        }

        CircleProgres {
            anchors.horizontalCenter: parent.horizontalCenter
            height: root.height / 5 * 4
            progresW: 14
            angleStart: 135
            angleEnd: 270
            progres: info[0]

            TextStyled {
                anchors.centerIn: parent
                text: type === 2 ? (info[1] + "Гб")
                    : (info[1] + "%")
            }

            TextStyled {
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                text: type === 2 ? (info[2] + "Гб")
                    : (info[2] + "°C")
            }
        }
    }
}