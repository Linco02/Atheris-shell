import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

ScrollStyled {
    padding: Style.padding.normal

    ColumnStyled {
        width: parent.width

        Item {
            height: 30; width: parent.width

            ButtonStyled {
                anchors {
                    left: parent.left
                }
                height: parent.height; width: height
                text: ""
                onClicked: SWManager.controlCenter("main")
            }

            ButtonToggle {
                id: toggleBluetooth
                anchors.right: parent.right
                height: parent.height
                onClicked: SNetwork.toggleWifi()
                isActive: SNetwork.isWifiOn
            }
        }
    }
}

// ColumnStyled {
//     id: root
//     anchors.fill: parent

//     RectForeground {
//         height: root.height - button.height; width: root.width

//         ScrollView {
//             anchors.fill: parent
//             contentWidth: -1
//             ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
//             ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            
//             ColumnStyled {
//                 topPadding: Style.padding.normal

//                 TextStyled {
//                     anchors.horizontalCenter: parent.horizontalCenter
//                     visible: activeWifi.count > 0
//                     text: activeWifi.count > 1 ? "Активні мережі" : "Активна мережа"
//                 }

//                 Repeater {
//                     id: activeWifi
//                     model: SNetwork.wifiList.filter(w => w.ssid !== undefined && w.active === "так")
//                     delegate: RectInactive {
//                         height: 40; width: root.width

//                         RowStyled {
//                             anchors.verticalCenter: parent.verticalCenter
//                             leftPadding: Style.padding.normal

//                             TextStyled {
//                                 text: modelData.icon
//                             }

//                             TextStyled {
//                                 text: modelData.ssid
//                             }
//                         }
//                     }
//                 }

//                 TextStyled {
//                     anchors.horizontalCenter: parent.horizontalCenter
//                     visible: avalibleWifi.count > 0
//                     text: avalibleWifi.count > 1 ? "Доступні мережі" : "Доступна мережа"
//                 }
                
//                 Repeater {
//                     id: avalibleWifi
//                     model: SNetwork.wifiList.filter(w => w.ssid !== undefined && w.active === "ні")
//                     delegate: RectInactive {
//                         height: 40; width: root.width

//                         RowStyled {
//                             anchors.verticalCenter: parent.verticalCenter
//                             leftPadding: Style.padding.normal

//                             TextStyled {
//                                 text: modelData.icon
//                             }

//                             TextStyled {
//                                 text: modelData.ssid
//                             }
//                         }

//                         TapHandler {onTapped: SNetwork.connectWifi(modelData.ssid, "")}
//                     }
//                 }
//             }
//         }
//     }
// }