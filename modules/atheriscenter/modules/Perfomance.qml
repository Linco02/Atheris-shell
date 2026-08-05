import QtQuick
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.components.indicators
import qs.config
import qs.services
import "./components"

Item {
    id: root
    height: perfomanceContainer.height; width: perfomanceContainer.width

    ColumnStyled {
        id: perfomanceContainer
        anchors.horizontalCenter: parent.horizontalCenter

        RowStyled {
            id: box1

            PerfomanceUsage { type: 0 }
            PerfomanceUsage { type: 1 }
            PerfomanceUsage { type: 2 }
        }
        
        ColumnStyled {
            Repeater {
                model: SPerfomance.disks

                delegate: DiskUsage {
                    height: 44; width: root.width
                    name: modelData.name
                    load: modelData.total - modelData.avail
                    empty: modelData.avail
                    percent: modelData.percent
                }
            }
        }
    }
}