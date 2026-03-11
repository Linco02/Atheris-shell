import QtQuick
import Quickshell
import qs.config
import qs.components.shapes

import qs.services

PopupWindow {
    anchor {
        window: root
        rect.y: root.height + Appearance.padding.normal
        rect.x: root.width - width - Appearance.padding.normal
    }
    implicitHeight: 600; implicitWidth: 500
    visible: false
    // color: '#1f1869c5'
    color: "transparent"

    function openMenu() {
        if(visible) {
            visible = false
        } else {
            visible = true
        }
    }

    Palit {
        id: testcolor
    }

    RectBackground {
        x: parent.width - width
        height: 500; width: 400
        border.width: 2
        border.color: Colors.outline

        Column {
            anchors.fill: parent
            spacing: Appearance.padding.large
            padding: Appearance.padding.large
            
            Info { }
            Row {
                Repeater {
                    model: testcolor.test

                    Rectangle {
                        height: 20; width: 20
                        color: modelData
                        Component.onCompleted: {
                            console.log(modelData)
                        }
                    }
                }
            }
            Services { }
            Notifi { }
        }
    }
}