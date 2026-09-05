import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.animations
import qs.components.containers
import qs.config
import qs.services

RectClip {
    id: root
    width: parent.width
    // color: Theme.surfaceRaised

    RectForeground {anchors.fill: parent}

    ColumnStyled {
        id: notifiContainer
        anchors.fill: parent

        RowStyled {
            id: head

            TextStyled {
                anchors.verticalCenter: parent.verticalCenter
                text: "--- notifi"
            }

            ButtonStyled {
                height: 40; width: height
                text: ""
                onClicked: SNotification.clearNotifications()
            }
        }

        ScrollStyled {
            id: body
            height: root.height - head.height; width: parent.width

            ColumnStyled {
                anchors.fill: parent

                Repeater {
                    model: SNotification.server.trackedNotifications.values
                    delegate: Notifi {}
                }
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
                    SIcon.getIcon(iconName)
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