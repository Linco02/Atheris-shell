import QtQuick
import qs.components
import qs.modules
import qs.settings


RectForeground {
    id: perfomanceMiniWidget
    // implicitHeight: perfomanceMiniBox.height + Style.padding2x
    // implicitWidth: box1.width + Style.padding2x * 2
    property int ownHeight: height - Style.padding2x

    Row {
        id: perfomanceMiniBox
        anchors.centerIn: parent
        spacing: Style.padding2x

        PerfomanceGlipfMini {
            anchors.verticalCenter: parent.verticalCenter
            height: ownHeight; width: 20
            property string info3: "GPU"
        }
        PerfomanceGlipfMini {
            anchors.verticalCenter: parent.verticalCenter
            height: ownHeight; width: 20
            property string info3: "CPU"
        }
        PerfomanceGlipfMini {
            anchors.verticalCenter: parent.verticalCenter
            height: ownHeight; width: 20
            property string info3: "MEM"
        }
    }
}