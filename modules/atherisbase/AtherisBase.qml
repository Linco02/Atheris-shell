import QtQuick
import qs.config
import qs.services
import qs.components
import qs.components.shapes
import qs.components.windows
import qs.components.controls

Floating {
    id: root
    title: "Atheris-Base"
    minimumSize: "1000x700"
    implicitHeight: 800; implicitWidth: 1400
    onVisibleChanged: {
        if (!visible) {
            UIState.isAtherisBaseOpen = false
            // mainLoader.active = false
        }
    }

    readonly property int unitSize: Theme.unitSize.normal
    readonly property int margine: Theme.margine.large

    RectForeground {
        id: leftMenu
        anchors {
            left: parent.left
            leftMargin: Theme.margine.large
        }
        height: root.height - Theme.margine.large * 2; width: navMenu.width

        ListView {
            id: navMenu
            visible: !SDataBase.listBase
            height: parent.height; width: unitSize * 8
            orientation: ListView.Vertical
            interactive: true
            spacing: Theme.spacing.normal

            model: SDataBase?.listBase
            delegate: ButtonStyled {
                height: unitSize; width: parent.width
                text: modelData
                onClicked: baseMenu.model = SDataBase.getAllValues(modelData)
            }
        }
    }

    Rect {
        id: rightMenu
        anchors {
            top: root.top
            left: leftMenu.right
            leftMargin: Theme.margine.large
            right: root.right
            rightMargin: Theme.margine.large
        }
        height: leftMenu.height; width: root.width - navMenu.width - Theme.margine.large * 3

        ListView {
            id: baseMenu
            anchors.fill: parent
            orientation: ListView.Vertical
            interactive: true
            spacing: Theme.spacing.normal

            delegate: RectForeground {
                height: rowContainer.height + margine * 2; width: parent.width

                Row {
                    id: rowContainer
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: margine
                    }
                    spacing: Theme.spacing.large

                    Repeater {
                        model: modelData
                            ? Object.keys(modelData)
                                .filter(i => i.startsWith("image"))
                                .map(i => modelData[i])
                            : []

                        delegate: Image {
                            height: Theme.unitSize.large
                            width: implicitHeight > implicitWidth ? height / 16 * 9 : height / 9 * 16
                            source: modelData
                        }
                    }

                    Column {
                        Repeater {
                            model: modelData
                                ? Object.keys(modelData)
                                    .filter(i => i.startsWith("label") || i.startsWith("state"))
                                    .map(i => modelData[i])
                                : []
                            
                            TextStyled {
                                text: modelData
                            }
                        }
                    }
                }
            }
        }
    }
}