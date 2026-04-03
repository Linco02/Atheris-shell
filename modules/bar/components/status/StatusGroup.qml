import QtQuick
import qs.components.shapes
import qs.config

RectForeground {
    height: parent.height
    width: statusGroupContainer.width + Global.padding.normal

    Row {
        id: statusGroupContainer
        anchors.centerIn: parent
        height: parent.height
        spacing: Global.spacing.large
        leftPadding: Global.padding.normal
        rightPadding: Global.padding.normal

        Battery { anchors.verticalCenter: parent.verticalCenter }
        Volume { anchors.verticalCenter: parent.verticalCenter }
        Network { anchors.verticalCenter: parent.verticalCenter }
        Language { anchors.verticalCenter: parent.verticalCenter }
    }
}