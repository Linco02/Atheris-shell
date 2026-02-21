import QtQuick
import qs.components
import qs.modules
import qs.settings


Item {
    id: perfomanceWidget
    implicitHeight: perfomanceBox.height
    implicitWidth: perfomanceBox.width

    Column {
        id: perfomanceBox
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Style.padding2x

        Row {
            id: box1
            spacing: Style.padding2x

            PerfomanceGliph {
                id: gpuInfo
                property string info3: "GPU"
            }

            PerfomanceGliph {
                property string info3: "CPU"
            }

            PerfomanceGliph {
                property string info3: "MEM"
            }
        }
        
        Column {
            id: box2
            spacing: Style.padding2x

            SpaceGliph2 {
                height: 60; width: box1.width
            }

            // SpaceGliph2 {
            //     height: 60; width: perfomanceBox.width
            // }
        }
    }
}