import QtQuick
import qs.components
import qs.settings

Item {
    id: dashBoaradWidget
    implicitHeight: box.height + Style.padding2x
    implicitWidth: box.width + Style.padding2x * 2

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
                RectForeground {
                    height: 300; implicitWidth: 300
                }

                RectForeground {
                    height: 300; implicitWidth: 100
                }
            }
        }

        RectForeground {
            height: box.height; implicitWidth: 300
        }
    }


}
