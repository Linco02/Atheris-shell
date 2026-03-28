import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Services.Notifications
import qs.config
import qs.services
import qs.components.shapes
import qs.components.containers
import qs.components

RectForeground {
    id: root
    height: 300; width: parent.width

    function setIcons(icon, urgent) {
        var iconChose = ""
        let path = Quickshell.iconPath(icon, true)
        
        if (path) {
            if (path !== "")
                iconChose = icon
        } else {
            if (urgent === 0)
                iconChose = "dialog-information"
            if (urgent === 1)
                iconChose = "dialog-warning"
            if (urgent === 2)
                iconChose = "dialog-error"
        }

        return Quickshell.iconPath(iconChose)
    }

    RectClip {
        anchors.centerIn: parent
        height: parent.height - Appearance.padding.large
        width: parent.width - Appearance.padding.large
        radius: root.radius - parent.Appearance.padding.normal

        ScrollView {
            anchors.fill: parent
            contentWidth: -1
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            Column {
                anchors.fill: parent
                width: parent.width
                spacing: Appearance.padding.normal

                Repeater {
                    model: NotifiServis.server.trackedNotifications.values

                    delegate: Rect {
                        height: 50; width: parent.width - parent.padding * 2
                        radius: root.radius - parent.Appearance.padding.normal
                        color: modelData.urgency === 0 ? Colors.inactive
                            : modelData.urgency === 2 ? Colors.warning
                            : Colors.active

                        Row {
                            height: parent.height

                            IconImage {
                                id: notifImage
                                implicitSize: parent.height
                                source: setIcons(modelData.image, modelData.urgency)
                            }

                            Column {
                                OwnText {
                                    text: modelData ? modelData.summary : ""
                                }
                                OwnText {
                                    text: modelData ? modelData.appName : ""
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: dismiss()
                        }

                        component OwnText: TextStyled {
                            color: modelData.urgency === 0 ? Colors.textInactive
                                : modelData.urgency === 2 ? Colors.textAccent
                                : Colors.textAccent
                        }
                    }
                }
            }
        }
    }
}