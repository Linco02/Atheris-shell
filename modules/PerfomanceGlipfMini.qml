import QtQuick
import qs.components
import qs.singletons
import qs.settings

Item {
    id: perfomanceGlipfMiniModules

    property var listData: info3 === "GPU" ? PerfomanceInit.gpu : info3 === "CPU" ? PerfomanceInit.cpu : PerfomanceInit.mem
    property double percent: listData.percent

    Behavior on percent {
        NumberAnimation {
            duration: Style.spedAnim
            easing.type: Easing.InOutQuad
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: Style.spacing
        
        RectInactive {
            height: perfomanceGlipfMiniModules.height - name.height - Style.padding2x * 2; width: perfomanceGlipfMiniModules.width
            RectActive {
                anchors.bottom: parent.bottom
                height: parent.height * percent ; width: parent.width
            }
        }

        TextStyle1 {
            id: name
            anchors.horizontalCenter: parent.horizontalCenter
            text: info3 === "GPU" ? "󰢮" : info3 === "CPU" ? "" : ""
        }
    }
}