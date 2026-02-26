import QtQuick
import qs.config
import qs.services
import qs.components.animations
import qs.components.shapes
import qs.components

Item {
    id: perfomanceGlipfMiniModules

    property var listData: info3 === "GPU" ? PerfomanceInit.gpu : info3 === "CPU" ? PerfomanceInit.cpu : PerfomanceInit.mem
    property double percent: listData.percent

    Behavior on percent { NumberAnim {} }

    Column {
        anchors.centerIn: parent
        spacing: Appearance.spacing.normal
        
        RectInactive {
            height: perfomanceGlipfMiniModules.height - name.height - Appearance.spacing.large
            width: perfomanceGlipfMiniModules.width
            bottomLeftRadius: 4; bottomRightRadius: 4
            RectActive {
                anchors.bottom: parent.bottom
                height: parent.height * percent; width: parent.width
                bottomLeftRadius: 4; bottomRightRadius: 4
            }
        }

        TextStyled {
            id: name
            anchors.horizontalCenter: parent.horizontalCenter
            text: info3 === "GPU" ? "󰢮" : info3 === "CPU" ? "" : ""
        }
    }
}