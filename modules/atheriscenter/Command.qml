import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers
import qs.config
import qs.services

Item {
    id: root
    height: commandContainer.height > 600
        ? 600
        : commandContainer.height < 300
        ? 300
        : commandContainer.height
    width: 400

    readonly property string currentMode: SCommand.currentMode

    TextInputStyled {
        id: textInput
        anchors {
            top: parent.top
            topMargin: Theme.padding.normal
        }
        height: 40; width: root.width
        inputFocus: true
        beforeText: ""
        placeholderText: STranslations.tr("search_placeholder")

        onEnteredTextChanged: SCommand.updateList(enteredText)
    }

    ScrollStyled {
        anchors {
            bottom: parent.bottom
            bottomMargin: Theme.padding.normal
        }
        height: root.height - textInput.height - Theme.padding.normal * 3
        width: root.width

        ColumnStyled {
            id: commandContainer

            Repeater {
                model: SCommand.currentList
                delegate: RectInactive {
                    height: 40; width: root.width

                    RowStyled {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: Theme.padding.normal
                        rightPadding: Theme.padding.normal

                        TextStyled {
                            visible: currentMode === "command" || currentMode === "directory"
                            anchors.verticalCenter: parent.verticalCenter
                            text: currentMode === "command" || currentMode === "directory"
                                ? modelData.icon || ""
                                : ""
                            
                        }

                        IconImage {
                            visible: currentMode === "applications"
                            asynchronous: true
                            implicitSize: parent.parent.height - Theme.padding.normal
                            source: currentMode === "applications"
                                ? SIcon.getIcon(modelData.icon) || ""
                                : ""
                        }

                        TextStyled {
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.name || modelData.label || ""
                        }
                    }

                    TapHandler {
                        onTapped: {
                            if (currentMode === "applications") {
                                if(!modelData.runInTerminal) modelData.execute()
                                else return
                            } else {
                                return
                            }
                        }
                    }
                }
            }
        }
    }
}