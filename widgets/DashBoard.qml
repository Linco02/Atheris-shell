import QtQuick
import qs.components
import qs.settings

Item {
    id: dashBoaradWidget
    implicitHeight: box.height
    implicitWidth: box.width

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        id: box
        spacing: 10
        Column {
            spacing: 10
            Row {
                spacing: 10
                ClockDate {
                    height: 100; implicitWidth: 200
                }

                Weather {
                    height: 100; implicitWidth: 200
                }       
            }

            Row {
                spacing: 10
                Calendar {
                    height: 300; implicitWidth: 300
                }

                PerfomanceMini {
                    height: 300; implicitWidth: 100
                }
            }
        }

        MusicMini {
            height: box.height; implicitWidth: 300
        }
    }


}
