import QtQuick
import qs.components
import qs.modules
import qs.settings


RectForeground {
    id: perfomanceMiniWidget
    implicitHeight: perfomanceMiniBox.height + Style.padding2x
    implicitWidth: box1.width + Style.padding2x * 2

    Row {
        id: perfomanceMiniBox
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Style.padding2x

        PerfomanceGlipfMini {
            id: gpuInfo
            property string info3: "GPU"
        }
    }
}