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
            padding: Style.padding.large

            InformationBlock {
                leftText: "Nixos Версія"
                rightText: Update.systemVersion
            }

            InformationBlock {
                leftText: "Shell вресія"
                rightText: Update.shellVersion
            }

            Item{
                height: 40; width: parent.width - Style.padding.large * 2

                TextStyledB {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                    }
                    text: "Дата оновлення"
                }

                RowStyled {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                    }

                    TextStyledB {
                        text: STime.organizeDate(Update.systemDateUpdate, "-") || ""
                    }

                    ButtonStyled {
                        height: parent.height; width: height
                        text: ""
                        onClicked: Update.updateShell()
                    }
                }
            }
        }
    }

    TextStyled {
        leftPadding: Style.padding.large
        text: STranslations.tr("update_version_title")
    }


    RectForeground {
        height: updateInfo.height; width: parent.width
        clip: true

        ColumnStyled {
            id: pcInfo
            width: parent.width
            height: 200
            padding: Style.padding.large
        }
    }

    component InformationBlock: Item{
        height: 40; width: parent.width - Style.padding.large * 2

        property alias leftText: left.text
        property alias rightText: right.text

        TextStyledB {
            id: left
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
            }
        }
        TextStyledB {
            id: right
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
            }
        }
    }
}