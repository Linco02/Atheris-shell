import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.components.containers
import qs.config
import qs.services

RectForeground {
    width: parent.width

    ScrollView {
        anchors.fill: parent
        contentWidth: -1
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        ColumnStyled {
            anchors.fill: parent

            Repeater {
                model: SNotification.server.trackedNotifications.values
                delegate: Notifi {}
            }
        }
    }

    component Notifi: RectInactive {
        height: 50; width: parent.width

        RowStyled {
            height: parent.height

            IconImage {
                implicitSize: parent.height
                source: {
                    const iconName = modelData.image.replace("image://icon/", "")
                    SAppIcons.getIcon(iconName)
                }
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter

                TextStyled {text: modelData ? modelData.appName : ""}
                TextStyled {text: modelData ? modelData.summary : ""}
                TextStyled {text: modelData ? modelData.body : ""}
            }

            // SmartViewer {
            //     content: modelData.image
            // }
        }

        TapHandler {onTapped: dismiss()}
    }
}