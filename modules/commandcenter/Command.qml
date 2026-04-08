import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config

Column {
    id: root
    width: 400
    spacing: 10

    property int brickH: 40
    property var list: {
        let command = Global.commandCenterModules.filter(m => m.label !== "command")
        const directory = [{label: "directory", icon: "D"}]
        const applications = [{label: "applications", icon: "A"}]

        const input = textInput.text;
        if (input.length === 0) return applications;

        const first = input[0];
        const query = input.slice(1).toLowerCase();

        let base = [];
        if (first === ">") {
            base = command
        } else if (first === "/") {
            base = directory
        } else {
            base = applications
            return base.filter(m => m.label.toLowerCase().includes(input.toLowerCase()));
        }

        if (query.length === 0) return base;
        return base.filter(m => m.label.toLowerCase().includes(query));
    }

    RectActive {
        id: textInputContainer
        height: brickH; width: root.width

        RowSpaced {
            leftPadding: Global.padding.normal
            rightPadding: Global.padding.normal
            height: parent.height

            TextStyled {
                anchors.verticalCenter: parent.verticalCenter
                color: Colors.textAccent
                text: ""
            }

            TextInputStyled {
                id: textInput
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height / 2; width: textInputContainer.width
                autoScroll: false
                focus: true
                color: Colors.textAccent
            }
        }
    }

    RectForeground {
        height: 4; width: root.width
    }

    Repeater {
        model: list
        delegate: RectInactive {
            height: brickH; width: root.width

            RowSpaced {
                leftPadding: Global.padding.normal
                rightPadding: Global.padding.normal
                height: parent.height

                TextStyled {
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData.icon
                }

                TextStyled {
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData.label
                }
            }

            TapHandler { onTapped: { Global.controlCenterModul = modelData.label } }
        }
    }
}