import QtQuick
import qs.components
import qs.modules


RectBackground {
    anchors.centerIn: parent
    implicitHeight: 330; implicitWidth: gpuInfo.width * 3 + 40

    PerfomanceGliph {
        id: gpuInfo
        y: 10; x: 10
        property string info3: "GPU"
    }

    PerfomanceGliph {
        id: cpuInfo
        y: 10; x: 200 + 40
        property string info3: "CPU"
    }

    PerfomanceGliph {
        id: memInfo
        // anchors.left: cpuInfo.right
        y: 10; x: 400 + 70
        property string info3: "MEM"
    }

    SpaceGliph {
        id: memSpace
        y: gpuInfo.height + 20; x: 10
    }
}
