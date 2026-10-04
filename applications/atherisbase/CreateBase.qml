import QtQuick
import qs.config
import qs.components
import qs.components.shapes
import qs.components.controls

Column {
    id: root
    spacing: spacingL

    readonly property int margineL: Theme.margine.large
    readonly property int spacingN: Theme.spacing.normal
    readonly property int spacingL: Theme.spacing.large

    RectForeground {
        height: baseDataCreate.height + margineL * 2
        width: root.width

        Column {
            id: baseDataCreate
            anchors.centerIn: parent
            spacing: spacingN
            width: parent.width - margineL * 2

            LabelTextInput {
                anchors.horizontalCenter: parent.horizontalCenter
                height: unitSize; width: parent.width
                text: "Назва бази qtr"
            }

            Repeater {
                model: [
                    {"label": "Додати зображення qtr", "commandP": "", "commandM": ""},
                    {"label": "Додати текст qtr", "commandP": "", "commandM": ""},
                    {"label": "Додати статус qtr", "commandP": "", "commandM": ""},
                    {"label": "Додати посилання qtr", "commandP": "", "commandM": ""},
                    {"label": "Додати дочірню базу qtr", "commandP": "", "commandM": ""}
                ]

                delegate: LabelButtonPM {
                    height: unitSize; width: parent.width
                    text: modelData.label
                    spacing: spacingN
                    // onPClicked:
                    // onMClicked:
                }
            }
        }
    }

    property var dateT1: []

    RectForeground {
        height: unitSizeL + margineL * 2; width: root.width

        ImageStyled {
            anchors {
                left: parent.left
                leftMargin: margineL
                verticalCenter: parent.verticalCenter
            }
            height: unitSizeL; width: height * 9 / 16
        }

        Column {
            Repeater {
                model: dateT1
                delegate: Item {

                }
            }
        }

        // Row {
        //     id: baseBlock
        //     anchors {
        //         left: parent.left
        //         leftMargin: margineL
        //         top: parent.top
        //         topMargin: margineL
        //     }
        //     spacing: spacingL

        //     RectInactive {
        //         height: unitSizeL; width: height * 9 / 16
        //     }

        //     Column {
        //         anchors.verticalCenter: parent.verticalCenter

        //         TextStyled {text: "label"}
        //         TextStyled {text: "state"}
        //     }
        // }
    }
}