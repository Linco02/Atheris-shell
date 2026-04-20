import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

ScrollView {
    id: root
    contentWidth: -1
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.vertical.policy: ScrollBar.AlwaysOff
    height: commandContainer.height > 600 ? 600 : commandContainer.height
    width: 400

    property int brickH: 40
    property var command: Global.commandCenterModules.filter(m => m.label !== "command")
    property var directory: [{label: "directory", icon: "D"}]
    property var applications: CommandServices.applications
    property string mode: {
        const first = textInput.text[0];
        if (first === ">") return "command"
        if (first === "/") return "directory"
        return "applications"
    }
    property var list: {
        const input = textInput.text;
        if (input.length === 0) return applications;

        const query = input.slice(1).toLowerCase();

        let base = [];
        if (mode === "command") base = command
        else if (mode === "directory") base = directory
        else {
            base = applications
            return base.filter(m => m.label.toLowerCase().includes(input.toLowerCase()));
        }

        if (query.length === 0) return base;
        return base.filter(m => m.label.toLowerCase().includes(query));
    }

    function enterMode(mode) {
        if (mode === "command") {
            Global.commandCenterModule = list[0].label
        }
    }

    ColumnSpaced {
        id: commandContainer
        width: parent.width

        RectActive {
            id: textInputContainer
            height: brickH; width: parent.width

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
                    focus: true
                    color: Colors.textAccent
                    onEntered: enterMode(mode)

                    Component.onCompleted: forceActiveFocus()
                }
            }
        }

        RectForeground {
            height: 4; width: parent.width
        }

        Repeater {
            model: list
            delegate: RectInactive {
                height: brickH; width: parent.width

                Loader {
                    active: mode === "command"
                    sourceComponent: RowOwn {
                        TextStyled {
                            visible: mode === "command"
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.icon
                        }

                        TextStyled {
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData?.label
                        }
                    }
                }

                Loader {
                    active: mode === "applications"
                    sourceComponent: RowOwn {
                        IconsViewer {
                            visible: mode === "applications"
                            icon: modelData.icon
                        }

                        TextStyled {
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.name
                        }
                    }
                }

                TapHandler {
                    onTapped: {
                        if (mode === "command")
                            Global.commandCenterModule = modelData.label
                        else if (mode === "applications")
                            modelData.execute()
                    }
                }
            }
        }
    }

    component RowOwn: RowSpaced {
        leftPadding: Global.padding.normal
        rightPadding: Global.padding.normal
        height: parent.height
    }
}