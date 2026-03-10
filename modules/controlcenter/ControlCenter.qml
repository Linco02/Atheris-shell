import QtQuick
import Quickshell
import qs.config
import qs.components.shapes

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

    RectBackground {
        x: parent.width - width
        height: 500; width: 400
        border.width: 2
        border.color: Appearance.outline

        // Item {
        //     anchors.centerIn: parent
        //     height: parent.height - Appearance.padding.large * 2
        //     width: parent.width - Appearance.padding.large * 2
            
        //     Column {
        //         anchors.fill: parent
        //         spacing: Appearance.padding.large
                
        //         Info { }
        //         Services { }
        //         Notifi { }
        //     }
        // }

        Column {
            anchors.fill: parent
            spacing: Appearance.padding.large
            padding: Appearance.padding.large
            
            Info { }
            Services { }
            Notifi { }
        }
    }
}