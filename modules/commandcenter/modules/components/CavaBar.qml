import QtQuick
import Quickshell.Io
import qs.services

Item {
    id: root
    
    property int barCount: 20
    property color barColor: "white"
    property int barWidth: 4
    property int barSpacing: 2
    
    width: barCount * (barWidth + barSpacing)
    height: 60
    
    // Бари
    Row {
        anchors.bottom: parent.bottom
        spacing: root.barSpacing
        
        Repeater {
            model: MrisServices.cavaBarsData
            
            Rectangle {
                width: root.barWidth
                height: Math.max(2, (modelData / 100) * root.height)
                radius: width / 2
                color: root.barColor
                anchors.bottom: parent.bottom
                
                Behavior on height {
                    NumberAnimation {
                        duration: 80
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
    }
}