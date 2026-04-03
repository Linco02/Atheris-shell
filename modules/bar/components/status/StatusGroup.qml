import QtQuick
import qs.config
import qs.components.shapes

import qs.components

RectForeground {
    height: root.height - Appearance.padding.normal
    width: servicesContainer.width + Appearance.padding.normal

    Row {
        id: servicesContainer
        anchors.centerIn: parent
        height: parent.height - Appearance.padding.small
        spacing: Appearance.padding.large
        leftPadding: Appearance.padding.normal
        rightPadding: Appearance.padding.normal

        Battery {
            anchors.verticalCenter: parent.verticalCenter
        }
        Volume {
            anchors.verticalCenter: parent.verticalCenter
        }
        Network {
            anchors.verticalCenter: parent.verticalCenter
        }
        Language {
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}