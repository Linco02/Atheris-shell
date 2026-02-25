import QtQuick
import qs.config
import qs.components
import "./components"

Item {
    id: perfomanceWidget
    implicitHeight: perfomanceBox.height
    implicitWidth: perfomanceBox.width

    Column {
        id: perfomanceBox
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Appearance.padding.normal

        Row {
            id: box1
            spacing: Appearance.padding.normal

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
            spacing: Appearance.padding.normal

            SpaceGliph {
                height: 60; width: box1.width
            }

            // SpaceGliph {
            //     height: 60; width: perfomanceBox.width
            // }
        }
    }
}