import QtQuick
import qs.config
import qs.components.shapes

RectForeground {
    id: perfomanceMiniWidget
    // implicitHeight: perfomanceMiniBox.height + Style.padding2x
    // implicitWidth: box1.width + Style.padding2x * 2
    property int ownHeight: height - Appearance.padding.normal

    Row {
        id: perfomanceMiniBox
        anchors.centerIn: parent
        spacing: Appearance.padding.normal

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