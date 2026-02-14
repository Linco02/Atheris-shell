import QtQuick
import qs.components
import qs.modules
import qs.settings


Item {
    id: perfomanceWidget
    implicitHeight: gpuInfo.height + memSpace.height + 20
    implicitWidth: gpuInfo.width * 3 + 40
    y: 0; x: 20

    // property bool active: false
    // property real fade: - height

    // onActiveChanged: {
    //     if(active) {
    //         fade = 0
    //     } else {
    //         fade = - height
    //     }
    // }

    // Behavior on fade {
    //     NumberAnimation { duration: Style.spedAnim }
    // }

    PerfomanceGliph {
        id: gpuInfo
        x: Style.padding2x
        property string info3: "GPU"
    }

    PerfomanceGliph {
        id: cpuInfo
        x: width + Style.padding2x * 2
        property string info3: "CPU"
    }

    PerfomanceGliph {
        id: memInfo
        // anchors.left: cpuInfo.right
        x: width * 2 + Style.padding2x * 3
        property string info3: "MEM"
    }

    SpaceGliph2 {
        id: memSpace
        y: gpuInfo.height + Style.padding2x; x: Style.padding2x
    }
}
