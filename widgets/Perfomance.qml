import QtQuick
import qs.components
import qs.modules


Item {
    id: perfomanceWidget
    implicitHeight: gpuInfo.height + memSpace.height + 20
    implicitWidth: gpuInfo.width * 3 + 40
    y: -height; x: 20

    property bool active: false
    onActiveChanged: {
        if(active) {
            sleep.running = true
        } else {
            y = -height
        }
    }

    Timer {
        id: sleep
        interval: 300; running: false
        onTriggered: {
            fadeIn.start();
            y = 0
        }
    }

    NumberAnimation {
        id: fadeIn
        target: perfomanceWidget
        property: "y"
        from: -parent.height; to: 0
        duration: 300
        // easing.type: Easing.OutCubic
    }

    PerfomanceGliph {
        id: gpuInfo
        x: 10
        property string info3: "GPU"
    }

    PerfomanceGliph {
        id: cpuInfo
        x: 200 + 40
        property string info3: "CPU"
    }

    PerfomanceGliph {
        id: memInfo
        // anchors.left: cpuInfo.right
        x: 400 + 70
        property string info3: "MEM"
    }

    SpaceGliph {
        id: memSpace
        y: gpuInfo.height + 10; x: 10
    }
}
