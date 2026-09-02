import QtQuick
import qs.core
import qs.config
import qs.services
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers

ColumnStyled {
    id: root
    anchors.fill: parent

    TextStyled {
        leftPadding: Style.padding.large
        text: STranslations.tr("update_version_title")
    }

    RectForeground {
        height: updateInfo.height; width: parent.width
        clip: true

        ColumnStyled {
            id: updateInfo
            width: parent.width

            InformationBlock {
                leftText: "Nixos Версія"
                rightText: "dsahjk123"
            }

            InformationBlock {
                leftText: "Shell вресія"
                rightText: "usd43d"
            }

            InformationBlock {
                leftText: "Дата оновлення"
                rightText: "2026-19-23"
            }
        }

        // Grid {
        //     id: updateGrid

        //     TextStyledB {
        //         id: name
        //         width: parent.width - toggle.width - Style.padding.large * 3
        //         text: STranslations.tr("bluetooth")
        //     }
        //     ButtonToggle {
        //         id: toggle
        //         height: name.height
        //         isActive: SBluetooth?.isBluetoothOn
        //         onClicked: SBluetooth.toggleBluetooth()
        //     }

        //     TextStyledB {width: name.width; text: STranslations.tr("scanning")}
        //     ButtonToggle {
        //         height: toggle.height
        //         isActive: adapter?.discovering
        //         onClicked: SBluetooth.toggleDiscovering()
        //     }
        // }
    }

    RowStyled {
        ButtonStyled {
            height: 40; width: height
            text: ""
            onClicked: Update.updateShell()
        }

        TextStyled {
            text: STranslations.tr("update")
        }
    }

    component InformationBlock: Item{
        height: 40; width: parent.width

        property alias leftText: left.text
        property alias rightText: right.text

        TextStyledB {
            id: left
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: Style.margine.normal
            }
        }
        TextStyledB {
            id: right
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: Style.margine.normal
            }
        }
    }
}