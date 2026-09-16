import QtQuick
import qs.config
import qs.components
import qs.components.controls

Item {
    id: root
    height: label.height; width: parent.width - Theme.padding.large * 2

    property alias text: label.text
    property alias isActive: toggle.isActive
    property int margine: Theme.padding.normal

    signal clicked()

    TextStyledB {
        id: label
        anchors.left: parent.left
        width: parent.width - toggle.width - Theme.padding.large
    }

    ButtonToggle {
        id: toggle
        anchors.right: parent.right
        height: label.height
        onClicked: root.clicked()
    }
}