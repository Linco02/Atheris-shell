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

        ColumnSpaced {
            anchors.fill: parent

            Repeater {
                model: NotificationServices.server.trackedNotifications.values
                delegate: RectInactive {
                    height: 50; width: parent.width

                    RowSpaced {
                        height: parent.height

                        IconImage {
                            implicitSize: parent.height
                            source: {
                                let ico = modelData.image
                                const urg = modelData.urgency === 0 ? "low"
                                    : modelData.urgency === 1 ? "normal"
                                    : "critical"

                                if (ico === "") {
                                    ico = NotificationServices.notificationsUrgents
                                        .find(i => i.label === urg).icon
                                }
                                return AppIcons.getIcon(ico)
                            }
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            
                            TextStyled {
                                text: modelData ? modelData.summary : ""
                            }
                            TextStyled {
                                text: modelData ? modelData.body : ""
                            }
                        }
                    }

                    TapHandler { onTapped: dismiss() }
                }
            }
        }
    }
}