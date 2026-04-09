import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

RectForeground {
    id: root
    anchors.fill: parent

    ScrollView {
        anchors.fill: parent
        contentWidth: -1
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        
        ColumnSpaced {
            topPadding: Global.padding.normal

            TextStyled {
                anchors.horizontalCenter: parent.horizontalCenter
                visible: activeWifi.count > 0
                text: activeWifi.count > 1 ? "Активні мережі" : "Активна мережа"
            }

            Repeater {
                id: activeWifi
                model: NetworkServices.wifiList.filter(w => w.ssid !== undefined && w.active === "так")
                delegate: RectInactive {
                    height: 40; width: root.width

                    RowSpaced {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: Global.padding.normal

                        TextStyled {
                            text: modelData.icon
                        }

                        TextStyled {
                            text: modelData.ssid
                        }
                    }
                }
            }

            TextStyled {
                anchors.horizontalCenter: parent.horizontalCenter
                visible: avalibleWifi.count > 0
                text: avalibleWifi.count > 1 ? "Доступні мережі" : "Доступна мережа"
            }
            
            Repeater {
                id: avalibleWifi
                model: NetworkServices.wifiList.filter(w => w.ssid !== undefined && w.active === "ні")
                delegate: RectInactive {
                    height: 40; width: root.width

                    RowSpaced {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: Global.padding.normal

                        TextStyled {
                            text: modelData.icon
                        }

                        TextStyled {
                            text: modelData.ssid
                        }
                    }
                }
            }
        }
    }
}