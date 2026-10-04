import QtQuick
import Quickshell
import qs.config
import qs.components.shapes

RectClip {
    id: root

    property url source: QuickshellSettings.workingDirectory + "/../../assets/placeholder.png"

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        source: root.source
    }
}