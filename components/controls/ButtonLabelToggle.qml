import QtQuick
import qs.config
import qs.components
import qs.components.controls

Item {
    id: root
    
    property alias text: label.text
    property alias isActive: toggle.isActive

    signal clicked()

    TextStyledB {
        id: label
        anchors.left: parent.left
    }

    ButtonToggle {
        id: toggle
        anchors.right: parent.right
        height: root.height
        onClicked: root.clicked()
    }
}